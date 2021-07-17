//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit

public func vStack(
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    space: CGFloat = 0,
    isBaselineRelativeArrangement: Bool = false,
    isLayoutMarginsRelativeArrangement: Bool = false
) -> (UIView...) -> UIStackView {
    { (views: UIView...) in
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = space
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        stackView.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return stackView
    }
}

public func hStack(
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    space: CGFloat = 0,
    isBaselineRelativeArrangement: Bool = false,
    isLayoutMarginsRelativeArrangement: Bool = false
) -> (UIView...) -> UIStackView {
    { (views: UIView...) in
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = space
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        stackView.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return stackView
    }
}
