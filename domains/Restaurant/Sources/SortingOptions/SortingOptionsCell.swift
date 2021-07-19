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

import struct Entities.SortingOptionsDatasource

final class SortingOptionsCell: UITableViewCell {
    
    // MARK: - Properties
    private let checkboxImageView = with(UIImageView()) {
        $0.contentMode = .left
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private let optionNameLabel = with(UILabel()) {
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    
    private lazy var stackView = hStack(space: 12)(
        checkboxImageView,
        optionNameLabel
    )
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackView)
        
        stackView
            .alignEdges(leading: 15, trailing: -15, top: 10, bottom: -10)
            .activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Rx + Populate
extension SortingOptionsCell {
    var populate: Binder<SortingOptionsDatasource> {
        Binder(self) { target, datasource in
            target.checkboxImageView.image = datasource.isSelected
                ? UIImage(named: "checked")
                : UIImage(named: "unchecked")
            target.optionNameLabel.text = datasource.option
        }
    }
}
