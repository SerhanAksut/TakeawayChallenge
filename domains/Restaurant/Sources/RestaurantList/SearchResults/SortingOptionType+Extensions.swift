//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import enum Entities.SortingOptionType

import struct RestaurantReader.Restaurant

extension SortingOptionType {
    func sort(_ restaurants: [Restaurant]) -> [Restaurant] {
        var result: [Restaurant] = []
        switch self {
        case .bestMatch:
            result = restaurants.sorted {
                $0.sortingValues.bestMatch > $1.sortingValues.bestMatch
            }
        case .newest:
            result = restaurants.sorted {
                $0.sortingValues.newest > $1.sortingValues.newest
            }
        case .ratingAverage:
            result = restaurants.sorted {
                $0.sortingValues.ratingAverage > $1.sortingValues.ratingAverage
            }
        case .distance:
            result = restaurants.sorted {
                $0.sortingValues.distance < $1.sortingValues.distance
            }
        case .popularity:
            result = restaurants.sorted {
                $0.sortingValues.popularity > $1.sortingValues.popularity
            }
        case .averageProductPrice:
            result = restaurants.sorted {
                $0.sortingValues.averageProductPrice < $1.sortingValues.averageProductPrice
            }
        case .deliveryCosts:
            result = restaurants.sorted {
                $0.sortingValues.deliveryCosts < $1.sortingValues.deliveryCosts
            }
        case .minCost:
            result = restaurants.sorted {
                $0.sortingValues.minCost < $1.sortingValues.minCost
            }
        }
        return result.reorder()
    }
}
