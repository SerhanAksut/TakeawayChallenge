//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UISearchBar {
    var setEditing: Binder<Bool> {
        Binder(base) { target, isEditing in
            if isEditing {
                target.becomeFirstResponder()
            } else {
                target.resignFirstResponder()
            }
        }
    }
    
    var placeholder: Binder<String> {
        Binder(base) { target, value in
            target.placeholder = value
        }
    }
}
