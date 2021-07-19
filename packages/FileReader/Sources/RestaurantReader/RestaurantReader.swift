//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import RxSwift

public struct RestaurantReader {
    public var restaurantList: () -> Single<[Restaurant]>
    
    public init(
        restaurantList: @escaping () -> Single<[Restaurant]> = { .never() }
    ) {
        self.restaurantList = restaurantList
    }
}
