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
    public let sortingValues: RestaurantSortingValues
}

// MARK: - Extensions
public extension Array where Element == Restaurant {
    func reorder() -> Self {
        let open = self.filter { $0.status == .open }
        let orderAhead = self.filter { $0.status == .orderAhead }
        let closed = self.filter { $0.status == .closed }
        return open + orderAhead + closed
    }
}
