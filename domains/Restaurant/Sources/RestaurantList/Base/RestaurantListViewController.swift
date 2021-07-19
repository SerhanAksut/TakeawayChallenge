//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit
import RxSwift

import struct RestaurantReader.Restaurant

final class RestaurantListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = RestaurantListView()
    
    private lazy var searchBarController: RestaurantListSearchBarViewController = {
        let dependencies = RestaurantListSearchBarDependencies(
            viewModel: restaurantListSearchBarViewModel(_:),
            restaurantsEvent: restaurantsEvent,
            searchResultsObserver: restaurantsObserver
        )
        let controller = RestaurantListSearchBarViewController(with: dependencies)
        return controller
    }()
    
    private lazy var searchResultsController: RestaurantListSearchResultsViewController = {
        let dependencies = RestaurantListSearchResultsDependencies(
            viewModel: restaurantListSearchResultsViewModel(_:),
            restaurantsEvent: restaurantsEvent
        )
        let controller = RestaurantListSearchResultsViewController(with: dependencies)
        return controller
    }()
    
    private let bag = DisposeBag()
    private let dependencies: RestaurantListDependencies
    
    private let (restaurantsObserver, restaurantsEvent) = Observable<[Restaurant]>.pipe()
    
    // MARK: - Initialization
    init(with dependencies: RestaurantListDependencies) {
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
        
        navigationItem.rightBarButtonItem = viewSource.sortingOptionsBarButton
        addChildren()
        bindViewModelOutputs()
    }
}

// MARK: - Bind ViewModel Outputs
private extension RestaurantListViewController {
    func bindViewModelOutputs() {
        let outputs = dependencies.viewModel(inputs)
        
        bag.insert(
            outputs.navBarTitle.drive(navigationItem.rx.title),
            outputs.isLoading.drive(rx.showHideLoading),
            outputs.error.drive(rx.displayError),
            outputs.datasource.drive(restaurantsObserver),
            outputs.showSortingOptions
                .drive(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.dependencies.coordinator?.showSortingOptions.onNext($0)
                })
        )
    }
    
    var inputs: RestaurantListViewModelInput {
        let concurrentBackgroundQueue = ConcurrentDispatchQueueScheduler(qos: .background)
        let concurrentUserInitiatedQueue = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
        
        return RestaurantListViewModelInput(
            concurrentBackgroundQueue: concurrentBackgroundQueue,
            concurrentUserInitiatedQueue: concurrentUserInitiatedQueue,
            viewDidLoad: Observable.just(()),
            sortingOptionsButtonTapped: viewSource.sortingOptionsBarButton.rx.tap.asObservable()
        )
    }
}

// MARK: - Internal Helpers
private extension RestaurantListViewController {
    func addChildren() {
        [
            searchBarController,
            searchResultsController
        ]
        .forEach {
            addChildController(controller: $0) {
                viewSource.stackView.addArrangedSubview($0)
            }
        }
    }
}
