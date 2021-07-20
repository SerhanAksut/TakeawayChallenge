//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import RxSwift
import RxCocoa

import enum Entities.SortingOptionType

// MARK: - IO Models
struct SelectedSortingOptionViewModelInput {
    var concurrentBackgroundQueue: SchedulerType
    var sortingOptionSelectedAtIndex: Observable<Int?> = .never()
}

struct SelectedSortingOptionViewModelOutput {
    var value: Driver<String>
    let shouldHide: Driver<Bool>
}

typealias SelectedSortingOptionViewModel = (SelectedSortingOptionViewModelInput) -> SelectedSortingOptionViewModelOutput

// MARK: - IO Mapping
func selectedSortingOptionViewModel(
    _ inputs: SelectedSortingOptionViewModelInput
) -> SelectedSortingOptionViewModelOutput {
    let sortingOptionSelectedAtIndex = inputs.sortingOptionSelectedAtIndex.share()
    
    return SelectedSortingOptionViewModelOutput(
        value: getValueOutput(inputs, sortingOptionSelectedAtIndex),
        shouldHide: getShouldHideOutput(inputs, sortingOptionSelectedAtIndex)
    )
}

// MARK: - Value Output
private func getValueOutput(
    _ inputs: SelectedSortingOptionViewModelInput,
    _ sortingOptionSelectedAtIndex: Observable<Int?>
) -> Driver<String> {
    sortingOptionSelectedAtIndex
        .observe(on: inputs.concurrentBackgroundQueue)
        .compactMap { index -> String? in
            guard let index = index else { return nil }
            let allOptions = SortingOptionType.allCases.map(\.rawValue)
            return allOptions[index]
        }
        .distinctUntilChanged()
        .asDriver(onErrorDriveWith: .never())
}

// MARK: - ShouldHide Output
private func getShouldHideOutput(
    _ inputs: SelectedSortingOptionViewModelInput,
    _ sortingOptionSelectedAtIndex: Observable<Int?>
) -> Driver<Bool> {
    sortingOptionSelectedAtIndex
        .observe(on: inputs.concurrentBackgroundQueue)
        .map { $0 == nil }
        .distinctUntilChanged()
        .asDriver(onErrorDriveWith: .never())
}
