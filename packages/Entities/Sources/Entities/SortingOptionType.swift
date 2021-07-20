//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

public enum SortingOptionType: String, CaseIterable, Equatable {
    case bestMatch = "Best match"
    case newest = "Newest"
    case ratingAverage = "Rating average"
    case distance = "Distance"
    case popularity = "Popularity"
    case averageProductPrice = "Average product price"
    case deliveryCosts = "Delivery costs"
    case minCost = "Minimum cost"
}
