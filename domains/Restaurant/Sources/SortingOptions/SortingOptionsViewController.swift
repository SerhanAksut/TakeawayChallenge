//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit
import RxSwift

final class SortingOptionsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = SortingOptionsView()
    
    private let bag = DisposeBag()
    private let dependencies: SortingOptionsDependencies
    
    // MARK: - Initialization
    init(with dependencies: SortingOptionsDependencies) {
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
        
        navigationItem.title = Constants.navBarTitle
        bindViewModelOutputs()
    }
}

// MARK: - Bind ViewModel Outputs
private extension SortingOptionsViewController {
    func bindViewModelOutputs() {
        let outputs = dependencies.viewModel(inputs)
        
        bag.insert(
            outputs.selectedIndex
                .drive(onNext: { [weak self] in
                    self?.dependencies.selectedIndexObserver.onNext($0)
                    self?.dismiss(animated: true)
                }),
            
            outputs.datasource
                .asObservable()
                .bind(to: viewSource.tableView.rx.items(
                        cellIdentifier: SortingOptionsCell.viewIdentifier,
                        cellType: SortingOptionsCell.self
                    )
                ) { index, item, cell in
                    cell.populate.onNext(item)
                }
        )
    }
    
    var inputs: SortingOptionsViewModelInput {
        let concurrentBackgroundQueue = ConcurrentDispatchQueueScheduler(qos: .background)
        let concurrentUserInitiatedQueue = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
        
        let indexSelected = viewSource.tableView.rx.itemSelected
            .asObservable()
            .do(onNext: { [weak viewSource] in
                viewSource?.tableView.deselectRow(at: $0, animated: true)
            })
        
        return SortingOptionsViewModelInput(
            concurrentBackgroundQueue: concurrentBackgroundQueue,
            concurrentUserInitiatedQueue: concurrentUserInitiatedQueue,
            options: Observable.just(dependencies.options),
            indexSelected: indexSelected
        )
    }
}

// MARK: - Constants
private enum Constants {
    static let navBarTitle = "Sorting Options"
}
