//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import UIKit

import func Helper.with
import func Helper.hStack

final class SelectedSortingOptionView: UIView {
    
    // MARK: - Properties
    private let titleLabel = makeLabel(
        textColor: .black,
        font: .boldSystemFont(ofSize: 15),
        huggingPriority: .required,
        text: Constants.title
    )
    
    let valueLabel = makeLabel(
        textColor: .appOrangeColor,
        font: .systemFont(ofSize: 15),
        huggingPriority: .defaultLow
    )
    
    private lazy var stackView = hStack(space: 10)(
        titleLabel,
        valueLabel
    )
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        isHidden = true
        addSubview(stackView)
        stackView
            .alignEdges(leading: 15, trailing: -15, top: 10, bottom: -10)
            .activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Make Label
private func makeLabel(
    textColor: UIColor,
    font: UIFont,
    huggingPriority: UILayoutPriority,
    text: String? = nil
) -> UILabel {
    with(UILabel()) {
        $0.textAlignment = .left
        $0.textColor = textColor
        $0.font = font
        $0.text = text
        $0.setContentHuggingPriority(huggingPriority, for: .horizontal)
    }
}

// MARK: - Constants
private enum Constants {
    static let title = "Sort By:"
}
