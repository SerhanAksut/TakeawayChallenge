//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

import struct Entities.SortingOptionsDatasource

// MARK: - IO Models
struct SortingOptionsViewModelInput {
    var concurrentBackgroundQueue: SchedulerType
    var concurrentUserInitiatedQueue: SchedulerType
    var options: Observable<[SortingOptionsDatasource]> = .never()
    var indexSelected: Observable<IndexPath> = .never()
}

struct SortingOptionsViewModelOutput {
    let datasource: Driver<[SortingOptionsDatasource]>
    let selectedIndex: Driver<Int>
}

typealias SortingOptionsViewModel = (SortingOptionsViewModelInput) -> SortingOptionsViewModelOutput

// MARK: - IO Mapping
func sortingOptionsViewModel(
    _ inputs: SortingOptionsViewModelInput
) -> SortingOptionsViewModelOutput {
    SortingOptionsViewModelOutput(
        datasource: getDatasourceOutput(inputs),
        selectedIndex: getSelectedIndexOutput(inputs)
    )
}

// MARK: - Datasource Output
private func getDatasourceOutput(
    _ inputs: SortingOptionsViewModelInput
) -> Driver<[SortingOptionsDatasource]> {
    inputs.options
        .observe(on: inputs.concurrentBackgroundQueue)
        .take(1)
        .asDriver(onErrorDriveWith: .never())
}

// MARK: - SelectedIndex Output
private func getSelectedIndexOutput(
    _ inputs: SortingOptionsViewModelInput
) -> Driver<Int> {
    inputs.indexSelected
        .observe(on: inputs.concurrentUserInitiatedQueue)
        .map(\.row)
        .asDriver(onErrorDriveWith: .never())
}
