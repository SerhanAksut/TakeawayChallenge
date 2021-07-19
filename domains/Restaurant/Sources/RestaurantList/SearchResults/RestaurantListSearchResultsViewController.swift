//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit
import RxSwift

final class RestaurantListSearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = RestaurantListSearchResultsView()
    
    private let bag = DisposeBag()
    private let dependencies: RestaurantListSearchResultsDependencies
    
    // MARK: - Initialization
    init(with dependencies: RestaurantListSearchResultsDependencies) {
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
private extension RestaurantListSearchResultsViewController {
    func bindViewModelOutputs() {
        let outputs = dependencies.viewModel(inputs)
        
        bag.insert(
            outputs.restaurants
                .asObservable()
                .bind(to: viewSource.tableView.rx.items(
                        cellIdentifier: RestaurantListSearchResultsCell.viewIdentifier,
                        cellType: RestaurantListSearchResultsCell.self
                    )
                ) { index, item, cell in
                    cell.populate.onNext(item)
                }
        )
    }
    
    var inputs: RestaurantListSearchResultsViewModelInput {
        let concurrentBackgroundQueue = ConcurrentDispatchQueueScheduler(qos: .background)
        
        return RestaurantListSearchResultsViewModelInput(
            concurrentBackgroundQueue: concurrentBackgroundQueue,
            restaurants: dependencies.restaurantsEvent
        )
    }
}
