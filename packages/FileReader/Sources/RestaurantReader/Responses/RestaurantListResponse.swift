//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

public struct RestaurantListResponse: Decodable, Equatable {
    public let restaurants: [Restaurant]
}
