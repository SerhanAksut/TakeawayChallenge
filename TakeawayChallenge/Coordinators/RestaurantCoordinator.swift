//
//  RestaurantCoordinator.swift
//  TakeawayChallenge
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit
import RxSwift

import struct RestaurantList.RestaurantListBuilder

import protocol Coordinator.RestaurantCoordinatorProtocol

final class RestaurantCoordinator: RestaurantCoordinatorProtocol {
    private weak var navigationController: UINavigationController?
    
    func start(window: UIWindow?) {
        let controller = RestaurantListBuilder.build(coordinator: self)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.barTintColor = .appOrangeColor
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = .white
        window?.rootViewController = navigationController
        self.navigationController = navigationController
    }
    
    var showSortingOptions: Binder<[String]> {
        Binder(self) { target, options in
            
        }
    }
}
