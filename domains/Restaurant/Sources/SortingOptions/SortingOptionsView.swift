//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit

import func Helper.with

final class SortingOptionsView: UIView {
    
    // MARK: - Properties
    let tableView = with(UITableView(frame: .zero)) {
        $0.backgroundColor = .white
        $0.estimatedRowHeight = 50
        $0.keyboardDismissMode = .interactive
        $0.register(
            SortingOptionsCell.self,
            forCellReuseIdentifier: SortingOptionsCell.viewIdentifier
        )
        $0.tableFooterView = UIView()
    }
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(tableView)
        
        let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        tableView
            .alignEdges(bottom: -bottomInset)
            .activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
