//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import RxSwift
import RxCocoa

import struct RestaurantReader.Restaurant

import enum Entities.SortingOptionType

// MARK: - IO Models
struct RestaurantListSearchResultsViewModelInput {
    var concurrentBackgroundQueue: SchedulerType
    var concurrentUserInitiatedQueue: SchedulerType
    var allRestaurants: Observable<[Restaurant]> = .never()
    var searchResults: Observable<[Restaurant]> = .never()
    var sortingOptionSelectedAtIndex: Observable<Int?> = .never()
}

struct RestaurantListSearchResultsViewModelOutput {
    let restaurants: Driver<[Restaurant]>
}

typealias RestaurantListSearchResultsViewModel = (RestaurantListSearchResultsViewModelInput) -> RestaurantListSearchResultsViewModelOutput

// MARK: - IO Mapping
func restaurantListSearchResultsViewModel(
    _ inputs: RestaurantListSearchResultsViewModelInput
) -> RestaurantListSearchResultsViewModelOutput {
    RestaurantListSearchResultsViewModelOutput(
        restaurants: getRestaurantsOutput(inputs)
    )
}

// MARK: - Restaurants Output
private func getRestaurantsOutput(
    _ inputs: RestaurantListSearchResultsViewModelInput
) -> Driver<[Restaurant]> {
    let restaurants = Observable
        .merge(
            inputs.allRestaurants,
            inputs.searchResults
        )
        .observe(on: inputs.concurrentBackgroundQueue)
    
    let sortingOptionSelectedAtIndex = inputs.sortingOptionSelectedAtIndex
        .observe(on: inputs.concurrentUserInitiatedQueue)
        .withLatestFrom(restaurants) { index, restaurants -> [Restaurant] in
            guard let index = index else { return restaurants }
            let selectedOption = SortingOptionType.allCases[index]
            return selectedOption.sort(restaurants)
        }
    
    return Observable
        .merge(restaurants, sortingOptionSelectedAtIndex)
        .distinctUntilChanged()
        .asDriver(onErrorDriveWith: .never())
}
