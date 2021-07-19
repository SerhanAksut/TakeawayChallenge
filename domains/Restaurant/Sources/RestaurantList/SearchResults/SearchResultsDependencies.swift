//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import RxSwift

import struct RestaurantReader.Restaurant

struct SearchResultsDependencies {
    let viewModel: SearchResultsViewModel
    let allRestaurantsEvent: Observable<[Restaurant]>
    let searchResultsEvent: Observable<[Restaurant]>
    let sortingOptionSelectedAtIndexEvent: Observable<Int?>
}
