//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import UIKit
import RxSwift

final class RestaurantListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = RestaurantListView()
    
    private let bag = DisposeBag()
    private let viewModel: RestaurantListViewModel
    
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
        
        navigationItem.title = Constants.navBarTitle
        bindViewModelOutputs()
    }
}

// MARK: - Bind ViewModel Outputs
private extension RestaurantListViewController {
    func bindViewModelOutputs() {
        let outputs = viewModel(inputs)
        
        bag.insert(
            outputs.isLoading.drive(rx.showHideLoading),
            outputs.error.drive(rx.displayError)
        )
    }
    
    var inputs: RestaurantListViewModelInput {
        let concurrentBackgroundQueue = ConcurrentDispatchQueueScheduler(qos: .background)
        
        return RestaurantListViewModelInput(
            concurrentBackgroundQueue: concurrentBackgroundQueue,
            viewDidLoad: Observable.just(())
        )
    }
}

// MARK: - Constants
private enum Constants {
    static let navBarTitle = "Restaurants"
}
