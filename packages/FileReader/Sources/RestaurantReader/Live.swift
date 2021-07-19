//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import RxSwift
import FileReader

public extension RestaurantReader {
    static let live = Self(
        restaurantList: restaurantList
    )
}

// MARK: - Internal Helpers
private extension RestaurantReader {
    static func restaurantList() -> Single<[Restaurant]> {
        Single.create { single in
            let result = readFile(
                bundle: bundle,
                type: RestaurantListResponse.self,
                file: File.restaurantList.rawValue
            )
            switch result {
            case .success(let response):
                single(.success(response.restaurants.reorder()))
            case .failure(let error):
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
}
