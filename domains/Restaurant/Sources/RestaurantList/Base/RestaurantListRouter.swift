//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

import RxSwift
import RxCocoa

extension Reactive where Base == RestaurantListViewController {
    var showSortingOptions: Binder<[String]> {
        Binder(base) { target, options in
            
        }
    }
}
