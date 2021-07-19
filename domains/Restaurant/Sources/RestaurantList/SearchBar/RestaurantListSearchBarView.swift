//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit

import func Helper.with

final class RestaurantListSearchBarView: UIView {
    
    // MARK: - Properties
    let searchBar = with(UISearchBar()) {
        $0.tintColor = .white
        $0.backgroundColor = .appOrangeColor
        $0.barTintColor = .appOrangeColor
        $0.placeholder = Constants.searchRestaurant
        $0.returnKeyType = .done
        $0.backgroundImage = UIImage()
        $0.autocorrectionType = .no
        $0.enablesReturnKeyAutomatically = true
        $0.textField?.tintColor = .appOrangeColor
        $0.textField?.backgroundColor = .white
    }
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        addSubview(searchBar)
        searchBar.alignFitEdges().activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constants
private enum Constants {
    static let searchRestaurant = "Search Restaurant"
}
