//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit

import func Helper.with

final class SearchResultsView: UIView {
    
    // MARK: - Properties
    let tableView = with(UITableView(frame: .zero)) {
        $0.backgroundColor = .white
        $0.estimatedRowHeight = 80
        $0.keyboardDismissMode = .interactive
        $0.register(
            SearchResultsCell.self,
            forCellReuseIdentifier: SearchResultsCell.viewIdentifier
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
