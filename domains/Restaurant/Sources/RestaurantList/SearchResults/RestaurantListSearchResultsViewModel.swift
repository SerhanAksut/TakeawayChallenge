//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import RxSwift
import RxCocoa

import struct RestaurantReader.Restaurant

// MARK: - IO Models
struct RestaurantListSearchResultsViewModelInput {
    var concurrentBackgroundQueue: SchedulerType
    var allRestaurants: Observable<[Restaurant]> = .never()
    var searchResults: Observable<[Restaurant]> = .never()
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
    Observable
        .merge(
            inputs.allRestaurants,
            inputs.searchResults
        )
        .observe(on: inputs.concurrentBackgroundQueue)
        .distinctUntilChanged()
        .asDriver(onErrorDriveWith: .never())
}
