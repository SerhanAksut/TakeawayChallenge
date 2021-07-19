//
//  RestaurantCoordinator.swift
//  TakeawayChallenge
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit
import RxSwift

import struct RestaurantList.RestaurantListBuilder
import struct SortingOptions.SortingOptionsBuilder

import protocol Coordinator.RestaurantCoordinatorProtocol

import struct Entities.SortingOptionsDatasource

final class RestaurantCoordinator: RestaurantCoordinatorProtocol {
    private weak var navigationController: UINavigationController?
    
    func start(window: UIWindow?) {
        let controller = RestaurantListBuilder.build(coordinator: self)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.configure()
        window?.rootViewController = navigationController
        self.navigationController = navigationController
    }
    
    var showSortingOptions: Binder<([SortingOptionsDatasource], AnyObserver<Int?>)> {
        Binder(self) { target, data in
            let options = data.0
            let selectedIndexObserver = data.1
            let controller = SortingOptionsBuilder.build(
                options: options,
                selectedIndexObserver: selectedIndexObserver
            )
            let navController = UINavigationController(rootViewController: controller)
            navController.configure()
            self.navigationController?.present(navController, animated: true)
        }
    }
}
