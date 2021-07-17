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
        with(UIStackView(arrangedSubviews: views)) {
            $0.axis = .vertical
            $0.spacing = space
            $0.alignment = alignment
            $0.distribution = distribution
            $0.isBaselineRelativeArrangement = isBaselineRelativeArrangement
            $0.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        }
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
        with(UIStackView(arrangedSubviews: views)) {
            $0.axis = .horizontal
            $0.spacing = space
            $0.alignment = alignment
            $0.distribution = distribution
            $0.isBaselineRelativeArrangement = isBaselineRelativeArrangement
            $0.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        }
    }
}
