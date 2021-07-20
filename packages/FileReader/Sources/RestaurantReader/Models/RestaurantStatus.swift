//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import UIKit

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
    
    public var text: String? {
        switch self {
        case .open:
            return Constants.open
        case .closed:
            return Constants.closed
        case .orderAhead:
            return Constants.orderAhead
        case .unknown:
            return nil
        }
    }
    
    public var alpha: CGFloat {
        self == .closed
            ? 0.5
            : 1
    }
}

// MARK: - Constants
private enum Constants {
    static let open = "Open"
    static let closed = "Closed"
    static let orderAhead = "Order Ahead"
}
