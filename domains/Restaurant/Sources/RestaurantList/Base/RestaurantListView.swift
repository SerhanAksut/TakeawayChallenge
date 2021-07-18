//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit

import func Helper.with
import func Helper.vStack

final class RestaurantListView: UIView {
    
    // MARK: - Properties
    let stackView = vStack()()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.alignFitEdges().activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
