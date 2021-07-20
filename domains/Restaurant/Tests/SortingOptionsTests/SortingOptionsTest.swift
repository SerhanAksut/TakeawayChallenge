//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import XCTest
import RxTest

@testable import SortingOptions
@testable import Helper
@testable import RxTestHelper
@testable import Entities

class SortingOptionsTest: XCTestCase {
    
    var viewModel: SortingOptionsViewModel!
    var scheduler: TestScheduler!
    var inputs: SortingOptionsViewModelInput!
    
    override func setUp() {
        super.setUp()
        
        viewModel = sortingOptionsViewModel(_:)
        scheduler = TestScheduler(
            initialClock: 0,
            resolution: 0.1,
            simulateProcessingDelay: false
        )
        inputs = SortingOptionsViewModelInput(
            concurrentBackgroundQueue: scheduler,
            concurrentUserInitiatedQueue: scheduler
        )
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        inputs = nil
    }
    
    func test__datasource_when_options_input_handled() {
        inputs = with(inputs!) {
            $0.options = scheduler.cold(.next(5, .mock))
        }
        
        let outputs = viewModel(inputs)
        let datasource = scheduler.record(source: outputs.datasource)
        
        scheduler.start()
        
        XCTAssertEqual(datasource.events, [
            .next(5, .mock),
            .completed(5)
        ])
    }
}

// MARK: - Mock Data
extension Array where Element == SortingOptionsDatasource {
    static var mock: Self {
        SortingOptionType.allCases
            .enumerated()
            .map { index, option in
                let isSelected = index == 0
                return SortingOptionsDatasource(
                    option: option.rawValue,
                    isSelected: isSelected
                )
            }
    }
}
