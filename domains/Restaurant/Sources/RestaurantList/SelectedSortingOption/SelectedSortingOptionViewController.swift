//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import UIKit
import RxSwift

final class SelectedSortingOptionViewController: UIViewController {
    
    // MARK: - Properties
    private let viewSource = SelectedSortingOptionView()
    
    private let bag = DisposeBag()
    private let dependencies: SelectedSortingOptionDependencies
    
    // MARK: - Initialization
    init(with dependencies: SelectedSortingOptionDependencies) {
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
private extension SelectedSortingOptionViewController {
    func bindViewModelOutputs() {
        let outputs = dependencies.viewModel(inputs)
        
        bag.insert(
            outputs.shouldHide.drive(viewSource.rx.isHiddenWithAnimation),
            outputs.value.drive(viewSource.valueLabel.rx.text)
        )
    }
    
    var inputs: SelectedSortingOptionViewModelInput {
        let concurrentBackgroundQueue = ConcurrentDispatchQueueScheduler(qos: .background)
        
        return SelectedSortingOptionViewModelInput(
            concurrentBackgroundQueue: concurrentBackgroundQueue,
            sortingOptionSelectedAtIndex: dependencies.sortingOptionSelectedAtIndexEvent.startWith(nil)
        )
    }
}
