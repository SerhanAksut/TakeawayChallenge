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

// MARK: - External Helpers
public extension RestaurantSortingValues {
    var displayableDistance: String {
        if distance >= 1000 {
            let distanceInKm = String(distance / 1000)
            let result = formatDistance(distanceInKm)
            return "\(result) km"
        }
        return "\(distance) m"
    }
    
    var displayableDeliveryCost: Double {
        deliveryCosts / 100
    }
    
    var displayableMinCost: Double {
        minCost / 100
    }
    
    private func formatDistance(_ string: String) -> String {
        if string.last == "0" {
            let newString = String(string.dropLast())
            return formatDistance(newString)
        }
        return string
    }
}
