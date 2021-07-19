//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit
import RxSwift

import struct Entities.SortingOptionsDatasource

public struct SortingOptionsBuilder {
    public static func build(
        options: [SortingOptionsDatasource],
        selectedIndexObserver: AnyObserver<Int?>
    ) -> UIViewController {
        let dependencies = SortingOptionsDependencies(
            viewModel: sortingOptionsViewModel(_:),
            options: options,
            selectedIndexObserver: selectedIndexObserver
        )
        let controller = SortingOptionsViewController(with: dependencies)
        return controller
    }
}
