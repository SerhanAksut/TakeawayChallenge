//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import Foundation

final class BundleClass {}

let bundle = Bundle(for: BundleClass.self)

enum File: String {
    case restaurantList = "RestaurantList"
}
