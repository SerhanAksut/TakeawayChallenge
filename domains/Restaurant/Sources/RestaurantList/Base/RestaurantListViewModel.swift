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

// MARK: - IO Models
struct RestaurantListViewModelInput {
    var concurrentBackgroundQueue: SchedulerType
    var viewDidLoad: Observable<Void> = .never()
}

struct RestaurantListViewModelOutput {
    let isLoading: Driver<Bool>
    let error: Driver<ErrorObject>
}

typealias RestaurantListViewModel = (RestaurantListViewModelInput) -> RestaurantListViewModelOutput

// MARK: - IO Mapping
func restaurantListViewModel(
    _ inputs: RestaurantListViewModelInput
) -> RestaurantListViewModelOutput {
    let indicator = ActivityIndicator()
    
    return RestaurantListViewModelOutput(
        isLoading: indicator.asDriver(),
        error: .never()
    )
}
