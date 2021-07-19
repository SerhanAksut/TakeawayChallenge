//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit
import RxSwift

import func Helper.with
import func Helper.hStack

final class SearchResultsInfoItemView: UIView {
    
    // MARK: - Properties
    private let imageView = with(UIImageView()) {
        $0.contentMode = .left
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private let valueLabel = with(UILabel()) {
        $0.textAlignment = .left
        $0.textColor = .appLightGrey
        $0.font = .systemFont(ofSize: 12)
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private lazy var stackView = hStack(space: 5)(
        imageView,
        valueLabel
    )
    
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

// MARK: - Rx + Populate
extension SearchResultsInfoItemView {
    var populate: Binder<(UIImage?, String)> {
        Binder(self) { target, data in
            let image = data.0
            let value = data.1
            target.imageView.image = image
            target.valueLabel.text = value
        }
    }
}
