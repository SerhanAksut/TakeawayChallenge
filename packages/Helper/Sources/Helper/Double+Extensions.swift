//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import Foundation

public extension Double {
    private static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.currencyDecimalSeparator = "."
        formatter.currencySymbol = "€"
        formatter.positiveFormat = "0 ¤"
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var formattedPrice: String {
        return Double.priceFormatter.string(for: self) ?? ""
    }
}
