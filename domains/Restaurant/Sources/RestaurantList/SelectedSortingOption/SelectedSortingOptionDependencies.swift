//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import RxSwift

struct SelectedSortingOptionDependencies {
    let viewModel: SelectedSortingOptionViewModel
    let sortingOptionSelectedAtIndexEvent: Observable<Int?>
}
