//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit
import RxSwift

import func Helper.with
import func Helper.vStack

import struct RestaurantReader.Restaurant

final class RestaurantListSearchResultsCell: UITableViewCell {
    
    // MARK: - Properties
    private let restaurantNameLabel = makeLabel(
        textAlignment: .left,
        font: .systemFont(ofSize: 15, weight: .semibold),
        textColor: .black
    )
    
    private let statusLabel = makeLabel(
        textAlignment: .right,
        font: .systemFont(ofSize: 12),
        textColor: .appOrangeColor
    )
    
    private lazy var stackView = vStack(space: 5)(
        restaurantNameLabel,
        statusLabel
    )
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(stackView)
        stackView
            .alignEdges(leading: 15, trailing: -15, top: 10, bottom: -10)
            .activate()
        
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
            target.restaurantNameLabel.text = restaurant.name
            target.statusLabel.text = restaurant.status.text
            target.statusLabel.isHidden = restaurant.status.text == nil
        }
    }
}

// MARK: - Make Label
private func makeLabel(
    textAlignment: NSTextAlignment,
    font: UIFont,
    textColor: UIColor
) -> UILabel {
    with(UILabel()) {
        $0.textAlignment = textAlignment
        $0.numberOfLines = 0
        $0.font = font
        $0.textColor = textColor
    }
}
