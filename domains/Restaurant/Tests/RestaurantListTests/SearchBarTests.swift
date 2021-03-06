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

class SearchBarTest: XCTestCase {
    
    var viewModel: SearchBarViewModel!
    var scheduler: TestScheduler!
    var inputs: SearchBarViewModelInput!
    
    override func setUp() {
        super.setUp()
        
        viewModel = searchBarViewModel(_:)
        scheduler = TestScheduler(
            initialClock: 0,
            resolution: 0.1,
            simulateProcessingDelay: false
        )
        inputs = SearchBarViewModelInput(concurrentUserInitiatedQueue: scheduler)
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        inputs = nil
    }
    
    func test__searchResults_when_searchText_changed() {
        let restaurants: [Restaurant] = .mock
        inputs = with(inputs!) {
            $0.allRestaurants = scheduler.cold(.next(0, restaurants))
            $0.searchText = scheduler.hot(
                .next(5, "T"),
                .next(10, "Tando"),
                .next(15, "Not found"),
                .next(25, "Not Found")
            )
        }
        
        let outputs = viewModel(inputs)
        let searchResults = scheduler.record(source: outputs.searchResults)
        
        scheduler.start()
        
        XCTAssertEqual(searchResults.events, [
            .next(5, .mock),
            .next(10, [[Restaurant].mock[0]]),
            .next(15, [])
        ])
    }
}
