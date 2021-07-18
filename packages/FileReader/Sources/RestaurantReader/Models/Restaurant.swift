//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

public struct Restaurant: Decodable, Equatable {
    public let id: String
    public let name: String
    public let status: RestaurantStatus
}
