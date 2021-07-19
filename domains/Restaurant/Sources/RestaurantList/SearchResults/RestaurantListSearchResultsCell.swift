//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit
import RxSwift

import struct RestaurantReader.Restaurant

final class RestaurantListSearchResultsCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Rx + Populate
extension RestaurantListSearchResultsCell {
    var populate: Binder<Restaurant> {
        Binder(self) { target, restaurant in
            
        }
    }
}
