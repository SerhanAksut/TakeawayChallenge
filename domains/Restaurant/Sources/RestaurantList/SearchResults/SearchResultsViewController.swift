//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit
import RxSwift

final class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = SearchResultsView()
    
    private let bag = DisposeBag()
    private let dependencies: SearchResultsDependencies
    
    // MARK: - Initialization
    init(with dependencies: SearchResultsDependencies) {
        self.dependencies = dependencies
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModelOutputs()
    }
}

// MARK: - Bind ViewModel Outputs
private extension SearchResultsViewController {
    func bindViewModelOutputs() {
        let outputs = dependencies.viewModel(inputs)
        
        bag.insert(
            outputs.restaurants
                .asObservable()
                .bind(to: viewSource.tableView.rx.items(
                        cellIdentifier: SearchResultsCell.viewIdentifier,
                        cellType: SearchResultsCell.self
                    )
                ) { index, item, cell in
                    cell.populate.onNext(item)
                }
        )
    }
    
    var inputs: SearchResultsViewModelInput {
        let concurrentBackgroundQueue = ConcurrentDispatchQueueScheduler(qos: .background)
        let concurrentUserInitiatedQueue = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
        
        return SearchResultsViewModelInput(
            concurrentBackgroundQueue: concurrentBackgroundQueue,
            concurrentUserInitiatedQueue: concurrentUserInitiatedQueue,
            allRestaurants: dependencies.allRestaurantsEvent,
            searchResults: dependencies.searchResultsEvent,
            sortingOptionSelectedAtIndex: dependencies.sortingOptionSelectedAtIndexEvent
        )
    }
}
