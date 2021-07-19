//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

public struct RestaurantSortingValues: Decodable, Equatable {
    public let bestMatch: Double
    public let newest: Double
    public let ratingAverage: Double
    public let distance: Double
    public let popularity: Double
    public let averageProductPrice: Double
    public let deliveryCosts: Double
    public let minCost: Double
}
