//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import RxSwift

public protocol RestaurantCoordinatorProtocol: AnyObject {
    var showSortingOptions: Binder<[String]> { get }
}
