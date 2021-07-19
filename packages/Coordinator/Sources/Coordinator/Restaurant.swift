//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import RxSwift

import struct Entities.SortingOptionsDatasource

public protocol RestaurantCoordinatorProtocol: AnyObject {
    var showSortingOptions: Binder<([SortingOptionsDatasource], AnyObserver<Int?>)> { get }
}
