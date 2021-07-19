//
//  AppDelegate.swift
//  TakeawayChallenge
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let restaurantCoordinator = RestaurantCoordinator()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        restaurantCoordinator.start(window: window)
        return true
    }
}
