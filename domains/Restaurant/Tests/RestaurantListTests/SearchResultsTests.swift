//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import XCTest
import RxTest
import RxCocoa

@testable import RestaurantList
@testable import Helper
@testable import RxTestHelper
@testable import RestaurantReader
@testable import Entities

class SearchResultTest: XCTestCase {
    
    var viewModel: SearchResultsViewModel!
    var scheduler: TestScheduler!
    var inputs: SearchResultsViewModelInput!
    
    override func setUp() {
        super.setUp()
        
        viewModel = searchResultsViewModel(_:)
        scheduler = TestScheduler(
            initialClock: 0,
            resolution: 0.1,
            simulateProcessingDelay: false
        )
        inputs = SearchResultsViewModelInput(
            concurrentBackgroundQueue: scheduler,
            concurrentUserInitiatedQueue: scheduler
        )
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        inputs = nil
    }
    
    func test__restaurants_when_allRestaurants_and_searchResults_input_handled() {
        inputs = with(inputs!) {
            $0.allRestaurants = scheduler.cold(.next(5, .mock))
            $0.searchResults = scheduler.cold(.next(10, .singleMock))
        }
        
        let outputs = viewModel(inputs)
        let restaurants = scheduler.record(source: outputs.restaurants)
        
        scheduler.start()
        
        XCTAssertEqual(restaurants.events, [
            .next(5, .mock),
            .next(10, .singleMock)
        ])
    }
    
    func test__restaurants_when_sortingOptionSelectedAtIndex_input_handled() {
        inputs = with(inputs!) {
            $0.allRestaurants = scheduler.cold(.next(5, .mock))
            $0.sortingOptionSelectedAtIndex = scheduler.cold(.next(10, 2))
        }
        
        let outputs = viewModel(inputs)
        let restaurants = scheduler.record(source: outputs.restaurants)
        
        scheduler.start()
        
        XCTAssertEqual(restaurants.events, [
            .next(5, .mock)
        ])
    }
}
