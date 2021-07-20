//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import XCTest
import RxTest

@testable import RestaurantList
@testable import Helper
@testable import RxTestHelper
@testable import RestaurantReader
@testable import Entities

class SelectedSortingOptionTest: XCTestCase {
    
    var viewModel: SelectedSortingOptionViewModel!
    var scheduler: TestScheduler!
    var inputs: SelectedSortingOptionViewModelInput!
    
    override func setUp() {
        super.setUp()
        
        viewModel = selectedSortingOptionViewModel(_:)
        scheduler = TestScheduler(
            initialClock: 0,
            resolution: 0.1,
            simulateProcessingDelay: false
        )
        inputs = SelectedSortingOptionViewModelInput(concurrentBackgroundQueue: scheduler)
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        inputs = nil
    }
    
    func test__value_when_sortingOptionSelectedAtIndex_input_handled() {
        inputs = with(inputs!) {
            $0.sortingOptionSelectedAtIndex = scheduler.cold(
                .next(5, 0),
                .next(10, 1),
                .next(15, 1)
            )
        }
        
        let outputs = viewModel(inputs)
        let value = scheduler.record(source: outputs.value)
        
        scheduler.start()
        
        let expectedResult1 = SortingOptionType.allCases.map(\.rawValue)[0]
        let expectedResult2 = SortingOptionType.allCases.map(\.rawValue)[1]
        
        XCTAssertEqual(value.events, [
            .next(5, expectedResult1),
            .next(10, expectedResult2)
        ])
    }
    
    func test__shouldHide_when_sortingOptionSelectedAtIndex_input_handled() {
        inputs = with(inputs!) {
            $0.sortingOptionSelectedAtIndex = scheduler.cold(
                .next(5, nil),
                .next(10, 0),
                .next(15, 1),
                .next(20, 1)
            )
        }
        
        let outputs = viewModel(inputs)
        let shouldHide = scheduler.record(source: outputs.shouldHide)
        
        scheduler.start()
        
        XCTAssertEqual(shouldHide.events, [
            .next(5, true),
            .next(10, false)
        ])
    }
}
