//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import RxSwift
import RxCocoa

import class RxHelper.ActivityIndicator
import struct RxHelper.ErrorObject

import struct RestaurantReader.RestaurantReader
import struct RestaurantReader.Restaurant

// MARK: - IO Models
struct RestaurantListViewModelInput {
    var concurrentBackgroundQueue: SchedulerType
    var concurrentUserInitiatedQueue: SchedulerType
    var restaurantReader: RestaurantReader = .live
    var viewDidLoad: Observable<Void> = .never()
    var sortingOptionsButtonTapped: Observable<Void> = .never()
}

struct RestaurantListViewModelOutput {
    let navBarTitle: Driver<String>
    let isLoading: Driver<Bool>
    let error: Driver<ErrorObject>
    let datasource: Driver<[Restaurant]>
    let showSortingOptions: Driver<[String]>
}

typealias RestaurantListViewModel = (RestaurantListViewModelInput) -> RestaurantListViewModelOutput

// MARK: - IO Mapping
func restaurantListViewModel(
    _ inputs: RestaurantListViewModelInput
) -> RestaurantListViewModelOutput {
    let indicator = ActivityIndicator()
    let (restaurantListResult, restaurantListError) = getRestaurantList(inputs, indicator)
    
    return RestaurantListViewModelOutput(
        navBarTitle: getNavBarTitleOutput(inputs),
        isLoading: indicator.asDriver(),
        error: getErrorOutput(restaurantListError),
        datasource: restaurantListResult,
        showSortingOptions: getShowSortingOptionsOutput(inputs)
    )
}

// MARK: - RestaurantList Request
private func getRestaurantList(
    _ inputs: RestaurantListViewModelInput,
    _ indicator: ActivityIndicator
) -> (Driver<[Restaurant]>, Driver<Error>) {
    inputs.viewDidLoad
        .observe(on: inputs.concurrentBackgroundQueue)
        .take(1)
        .request(indicator, call: inputs.restaurantReader.restaurantList)
}

// MARK: - Error Output
private func getErrorOutput(
    _ error: Driver<Error>
) -> Driver<ErrorObject> {
    error
        .map { _ in
            ErrorObject(message: Constants.errorMessage)
        }
}

// MARK: - NavBarTitle Output
private func getNavBarTitleOutput(
    _ inputs: RestaurantListViewModelInput
) -> Driver<String> {
    inputs.viewDidLoad
        .observe(on: inputs.concurrentBackgroundQueue)
        .take(1)
        .map { Constants.navBarTitle }
        .asDriver(onErrorDriveWith: .never())
}

// MARK: - ShowSortingOptions Output
private func getShowSortingOptionsOutput(
    _ inputs: RestaurantListViewModelInput
) -> Driver<[String]> {
    inputs.sortingOptionsButtonTapped
        .observe(on: inputs.concurrentUserInitiatedQueue)
        .map { [] }
        .asDriver(onErrorDriveWith: .never())
}

// MARK: - Constants
private enum Constants {
    static let navBarTitle = "Restaurants"
    static let errorMessage = "An error occured. Please try again."
}
