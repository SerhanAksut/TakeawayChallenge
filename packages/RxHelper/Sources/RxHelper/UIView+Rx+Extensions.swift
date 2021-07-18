//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Hide/Show View with Animation
public extension Reactive where Base: UIView {
    var isHiddenWithAnimation: Binder<Bool> {
        Binder(base) { target, isHidden in
            UIView.animate(withDuration: 0.3) {
                target.isHidden = isHidden
                target.alpha = isHidden ? 0 : 1
            }
        }
    }
}
