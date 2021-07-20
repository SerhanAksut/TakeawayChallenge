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
@testable import RxHelper
@testable import RxTestHelper
@testable import RestaurantReader
@testable import FileReader
@testable import Entities

class RestaurantListTest: XCTestCase {
    
    var viewModel: RestaurantListViewModel!
    var scheduler: TestScheduler!
    var inputs: RestaurantListViewModelInput!
    
    override func setUp() {
        super.setUp()
        
        viewModel = restaurantListViewModel(_:)
        scheduler = TestScheduler(
            initialClock: 0,
            resolution: 0.1,
            simulateProcessingDelay: false
        )
        inputs = RestaurantListViewModelInput(
            concurrentBackgroundQueue: scheduler,
            concurrentUserInitiatedQueue: scheduler
        )
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        inputs = nil
    }
    
    func test__navBarTitle_when_viewDidLoad_input_handled() {
        inputs = with(inputs!) {
            $0.viewDidLoad = scheduler.cold(.next(5, ()))
        }
        
        let outputs = viewModel(inputs)
        let navBarTitle = scheduler.record(source: outputs.navBarTitle)
        
        scheduler.start()
        
        XCTAssertEqual(navBarTitle.events, [
            .next(5, "Restaurants"),
            .completed(5)
        ])
    }
    
    func test_isLoading_when_restaurantList_requested() {
        SharingScheduler.mock(scheduler: scheduler) {
            let reader = RestaurantReader(
                restaurantList: {
                    self.scheduler.single(10, .mock)
                }
            )
            inputs = with(inputs!) {
                $0.restaurantReader = reader
                $0.viewDidLoad = scheduler.cold(.next(5, ()))
            }
            
            let outputs = viewModel(inputs)
            let isLoading = scheduler.record(source: outputs.isLoading)
            _ = scheduler.record(source: outputs.datasource)
            
            scheduler.start()
            
            XCTAssertEqual(isLoading.events, [
                .next(0, false),
                .next(5, true),
                .next(15, false)
            ])
        }
    }
    
    func test__error_when_restaurantList_request_failed_with_error() {
        let reader = RestaurantReader(
            restaurantList: {
                self.scheduler.single(10, FileReaderError.invalidPath)
            }
        )
        inputs = with(inputs!) {
            $0.restaurantReader = reader
            $0.viewDidLoad = scheduler.cold(.next(5, ()))
        }
        
        let outputs = viewModel(inputs)
        let error = scheduler.record(source: outputs.error)
        _ = scheduler.record(source: outputs.datasource)
        
        scheduler.start()
        
        let expectedResult = ErrorObject(message: "An error occured. Please try again.")
        XCTAssertEqual(error.events, [
            .next(15, expectedResult),
            .completed(15)
        ])
    }
    
    func test__datasource_when_restaurantList_response_handled_with_success() {
        let reader = RestaurantReader(
            restaurantList: {
                self.scheduler.single(10, .mock)
            }
        )
        inputs = with(inputs!) {
            $0.restaurantReader = reader
            $0.viewDidLoad = scheduler.cold(.next(5, ()))
        }
        
        let outputs = viewModel(inputs)
        let datasource = scheduler.record(source: outputs.datasource)
        
        scheduler.start()
        
        XCTAssertEqual(datasource.events, [
            .next(15, .mock),
            .completed(15)
        ])
    }
    
    func test__showSortingOptions_when_sortingOptions_button_tapped() {
        inputs = with(inputs!) {
            $0.sortingOptionSelectedAtIndex = scheduler.cold(.next(0, 0))
            $0.sortingOptionsButtonTapped = scheduler.cold(.next(5, ()))
        }
        
        let outputs = viewModel(inputs)
        let showSortingOptions = scheduler.record(source: outputs.showSortingOptions)
        
        scheduler.start()
        
        let allOptions = SortingOptionType.allCases.map(\.rawValue)
        let expectedResult = allOptions
            .enumerated()
            .map { index, option -> SortingOptionsDatasource in
                let isSelected = index == 0
                return SortingOptionsDatasource(option: option, isSelected: isSelected)
            }
        
        XCTAssertEqual(showSortingOptions.events, [
            .next(5, expectedResult)
        ])
    }
}
