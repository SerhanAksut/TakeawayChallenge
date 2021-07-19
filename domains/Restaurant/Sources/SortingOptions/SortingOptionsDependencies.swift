//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import RxSwift

import struct Entities.SortingOptionsDatasource

struct SortingOptionsDependencies {
    let viewModel: SortingOptionsViewModel
    let options: [SortingOptionsDatasource]
    let selectedIndexObserver: AnyObserver<Int?>
}
