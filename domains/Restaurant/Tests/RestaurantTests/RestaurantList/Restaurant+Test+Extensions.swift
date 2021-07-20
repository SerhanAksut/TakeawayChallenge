//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

@testable import RestaurantReader

extension Array where Element == Restaurant {
    static var mock: Self {
        [
            Restaurant(
                id: "1",
                name: "Tandoori",
                status: .open,
                sortingValues: RestaurantSortingValues(
                    bestMatch: 1,
                    newest: 1,
                    ratingAverage: 1,
                    distance: 1,
                    popularity: 1,
                    averageProductPrice: 1,
                    deliveryCosts: 1,
                    minCost: 1
                )
            ),
            Restaurant(
                id: "2",
                name: "Tandsii",
                status: .orderAhead,
                sortingValues: RestaurantSortingValues(
                    bestMatch: 2,
                    newest: 2,
                    ratingAverage: 2,
                    distance: 2,
                    popularity: 2,
                    averageProductPrice: 2,
                    deliveryCosts: 2,
                    minCost: 2
                )
            ),
            Restaurant(
                id: "3",
                name: "Tandsii",
                status: .closed,
                sortingValues: RestaurantSortingValues(
                    bestMatch: 3,
                    newest: 3,
                    ratingAverage: 3,
                    distance: 3,
                    popularity: 3,
                    averageProductPrice: 3,
                    deliveryCosts: 3,
                    minCost: 3
                )
            )
        ]
    }
}

