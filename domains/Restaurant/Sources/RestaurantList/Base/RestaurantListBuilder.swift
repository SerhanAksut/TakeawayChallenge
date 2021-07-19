//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit

import protocol Coordinator.RestaurantCoordinatorProtocol

public struct RestaurantListBuilder {
    public static func build(
        coordinator: RestaurantCoordinatorProtocol?
    ) -> UIViewController {
        let dependencies = RestaurantListDependencies(
            viewModel: restaurantListViewModel(_:),
            coordinator: coordinator
        )
        let controller = RestaurantListViewController(with: dependencies)
        return controller
    }
}
