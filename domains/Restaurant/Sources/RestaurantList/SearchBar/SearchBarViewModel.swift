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
struct SearchBarViewModelInput {
    var concurrentUserInitiatedQueue: SchedulerType
    var searchText: Observable<String> = .never()
    var allRestaurants: Observable<[Restaurant]> = .never()
}

struct SearchBarViewModelOutput {
    let searchResults: Driver<[Restaurant]>
}

typealias SearchBarViewModel = (SearchBarViewModelInput) -> SearchBarViewModelOutput

// MARK: - IO Mapping
func searchBarViewModel(
    _ inputs: SearchBarViewModelInput
) -> SearchBarViewModelOutput {
    SearchBarViewModelOutput(
        searchResults: getSearchResultsOutput(inputs)
    )
}

// MARK: - SearchResults Output
private func getSearchResultsOutput(
    _ inputs: SearchBarViewModelInput
) -> Driver<[Restaurant]> {
    inputs.searchText
        .observe(on: inputs.concurrentUserInitiatedQueue)
        .withLatestFrom(inputs.allRestaurants) { keyword, allRestaurants -> [Restaurant] in
            let trimmedKeyword = keyword.trimmingCharacters(in: .whitespaces).lowercased()
            if trimmedKeyword.isEmpty {
                return allRestaurants
            } else {
                let result = allRestaurants.filter {
                    let trimmedName = $0.name.trimmingCharacters(in: .whitespaces).lowercased()
                    return trimmedName.contains(trimmedKeyword)
                }
                return result
            }
        }
        .distinctUntilChanged()
        .asDriver(onErrorDriveWith: .never())
}
