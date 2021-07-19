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
struct RestaurantListSearchBarViewModelInput {
    var concurrentUserInitiatedQueue: SchedulerType
    var searchText: Observable<String> = .never()
    var allRestaurants: Observable<[Restaurant]> = .never()
}

struct RestaurantListSearchBarViewModelOutput {
    let searchResults: Driver<[Restaurant]>
}

typealias RestaurantListSearchBarViewModel = (RestaurantListSearchBarViewModelInput) -> RestaurantListSearchBarViewModelOutput

// MARK: - IO Mapping
func restaurantListSearchBarViewModel(
    _ inputs: RestaurantListSearchBarViewModelInput
) -> RestaurantListSearchBarViewModelOutput {
    RestaurantListSearchBarViewModelOutput(
        searchResults: getSearchResultsOutput(inputs)
    )
}

// MARK: - SearchResults Output
private func getSearchResultsOutput(
    _ inputs: RestaurantListSearchBarViewModelInput
) -> Driver<[Restaurant]> {
    inputs.searchText
        .observe(on: inputs.concurrentUserInitiatedQueue)
        .withLatestFrom(inputs.allRestaurants) { keyword, allRestaurants -> [Restaurant] in
            let trimmedKeyword = keyword.trimmingCharacters(in: .whitespaces).lowercased()
            if trimmedKeyword.isEmpty {
                return allRestaurants
            } else {
                let result = allRestaurants.filter {
                    let trimmedName = $0.name.trimmingCharacters(in: .whitespaces)
                    return trimmedName
                        .lowercased()
                        .contains(trimmedKeyword)
                }
                return result
            }
        }
        .distinctUntilChanged()
        .asDriver(onErrorDriveWith: .never())
}
