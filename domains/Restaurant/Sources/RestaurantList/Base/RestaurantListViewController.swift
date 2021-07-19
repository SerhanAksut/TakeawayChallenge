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
    
    private let bag = DisposeBag()
    private let viewModel: RestaurantListViewModel
    
    private let (restaurantsObserver, restaurantsEvent) = Observable<[Restaurant]>.pipe()
    
    // MARK: - Initialization
    init(with viewModel: @escaping RestaurantListViewModel) {
        self.viewModel = viewModel
        
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
        bindViewModelOutputs()
    }
}

// MARK: - Bind ViewModel Outputs
private extension RestaurantListViewController {
    func bindViewModelOutputs() {
        let outputs = viewModel(inputs)
        
        bag.insert(
            outputs.navBarTitle.drive(navigationItem.rx.title),
            outputs.isLoading.drive(rx.showHideLoading),
            outputs.error.drive(rx.displayError),
            outputs.datasource.drive(restaurantsObserver),
            outputs.showSortingOptions.drive(rx.showSortingOptions)
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
