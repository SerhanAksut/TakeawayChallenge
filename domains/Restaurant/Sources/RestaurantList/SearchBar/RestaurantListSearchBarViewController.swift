//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit
import RxSwift

final class RestaurantListSearchBarViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = RestaurantListSearchBarView()
    
    private let bag = DisposeBag()
    private let dependencies: RestaurantListSearchBarDependencies
    
    // MARK: - Initialization
    init(with dependencies: RestaurantListSearchBarDependencies) {
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
private extension RestaurantListSearchBarViewController {
    func bindViewModelOutputs() {
        let outputs = dependencies.viewModel(inputs)
        
        bag.insert(
            outputs.searchResults.drive(dependencies.searchResultsObserver)
        )
    }
    
    var inputs: RestaurantListSearchBarViewModelInput {
        let concurrentUserInitiatedQueue = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
        
        return RestaurantListSearchBarViewModelInput(
            concurrentUserInitiatedQueue: concurrentUserInitiatedQueue,
            searchText: viewSource.searchBar.rx.text.orEmpty.asObservable(),
            allRestaurants: dependencies.allRestaurantsEvent
        )
    }
}
