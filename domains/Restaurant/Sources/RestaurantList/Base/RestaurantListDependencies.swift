//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import protocol Coordinator.RestaurantCoordinatorProtocol

struct RestaurantListDependencies {
    let viewModel: RestaurantListViewModel
    weak var coordinator: RestaurantCoordinatorProtocol?
}
