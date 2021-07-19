//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import RxSwift

import struct RestaurantReader.Restaurant

struct SearchBarDependencies {
    let viewModel: SearchBarViewModel
    let allRestaurantsEvent: Observable<[Restaurant]>
    let searchResultsObserver: AnyObserver<[Restaurant]>
}
