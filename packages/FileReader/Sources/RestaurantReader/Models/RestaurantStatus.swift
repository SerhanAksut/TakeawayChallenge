//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

public enum RestaurantStatus: String, Decodable, Equatable {
    case open
    case closed
    case orderAhead = "order ahead"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = RestaurantStatus(rawValue: value) ?? .unknown
    }
}
