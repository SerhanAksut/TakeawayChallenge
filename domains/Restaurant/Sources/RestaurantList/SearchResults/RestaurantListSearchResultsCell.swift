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
import func Helper.hStack

import struct RestaurantReader.Restaurant

final class RestaurantListSearchResultsCell: UITableViewCell {
    
    // MARK: - Properties
    private let ratingAverageLabel = makeLabel(
        textAlignment: .center,
        font: .boldSystemFont(ofSize: 15),
        textColor: .white,
        backgroundColor: .appOrangeColor,
        radius: 5,
        huggingPriority: .required
    )
    
    private let restaurantNameLabel = makeLabel(
        textAlignment: .left,
        font: .systemFont(ofSize: 15, weight: .semibold),
        textColor: .black
    )
    
    private let statusLabel = makeLabel(
        textAlignment: .right,
        font: .systemFont(ofSize: 12),
        textColor: .appOrangeColor,
        huggingPriority: .required
    )
    
    private lazy var topHStackView = hStack(space: 8)(
        ratingAverageLabel,
        restaurantNameLabel,
        statusLabel
    )
    
    private let distanceView = RestaurantListSearchResultsInfoItemView()
    private let deliveryCostView = RestaurantListSearchResultsInfoItemView()
    private let minCostView = RestaurantListSearchResultsInfoItemView()
    
    private lazy var bottomHStackView = hStack(space: 10)(
        distanceView,
        deliveryCostView,
        minCostView,
        UIView()
    )
    
    private lazy var baseStackView = vStack(space: 10)(
        topHStackView,
        bottomHStackView
    )
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(baseStackView)
        [
            baseStackView.alignEdges(leading: 15, trailing: -15, top: 10, bottom: -10),
            ratingAverageLabel.alignSize(width: 30, height: 30)
        ]
        .flatMap { $0 }
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
            let sortingValues = restaurant.sortingValues
            target.ratingAverageLabel.text = sortingValues.ratingAverage.description
            target.restaurantNameLabel.text = restaurant.name
            target.restaurantNameLabel.alpha = restaurant.status.alpha
            target.statusLabel.text = restaurant.status.text
            target.statusLabel.isHidden = restaurant.status.text == nil
            
            let distanceImage = UIImage(named: "distance")
            let distanceValue = sortingValues.displayableDistance
            target.distanceView.populate.onNext((distanceImage, distanceValue))
            
            let deliveryCostImage = UIImage(named: "delivery-cost")
            let deliveryCostValue = sortingValues.displayableDeliveryCost.formattedPrice
            target.deliveryCostView.populate.onNext((deliveryCostImage, deliveryCostValue))
            
            let minCostImage = UIImage(named: "min-cost")
            let minCostValue = sortingValues.displayableMinCost.formattedPrice
            target.minCostView.populate.onNext((minCostImage, minCostValue))
        }
    }
}

// MARK: - Make Label
private func makeLabel(
    textAlignment: NSTextAlignment,
    font: UIFont,
    textColor: UIColor,
    backgroundColor: UIColor = .white,
    radius: CGFloat = .zero,
    huggingPriority: UILayoutPriority = .defaultLow
) -> UILabel {
    with(UILabel()) {
        $0.textAlignment = textAlignment
        $0.numberOfLines = 0
        $0.font = font
        $0.textColor = textColor
        $0.backgroundColor = backgroundColor
        if radius > .zero {
            $0.layer.cornerRadius = radius
            $0.layer.masksToBounds = true
        }
        $0.setContentHuggingPriority(huggingPriority, for: .horizontal)
    }
}
