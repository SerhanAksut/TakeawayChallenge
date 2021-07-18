//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

public struct ErrorObject: Equatable {
    let title: String
    let message: String
    let buttonTitle: String
    
    public init(
        title: String = "Error",
        message: String,
        buttonTitle: String = "Ok"
    ) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
}

public extension Reactive where Base: UIViewController {
    var displayError: Binder<ErrorObject> {
        Binder(base) { target, error in
            let alertController = UIAlertController(
                title: error.title,
                message: error.message,
                preferredStyle: .alert
            )
            let action = UIAlertAction(title: error.buttonTitle, style: .default)
            alertController.addAction(action)
            target.present(alertController, animated: true)
        }
    }
    
    var showHideLoading: Binder<Bool> {
        Binder(base) { target, isLoading in
            isLoading
                ? showLoading(target)
                : hideLoading(target)
        }
    }
    
    private func showLoading(_ target: Base) {
        
    }
    
    private func hideLoading(_ target: Base) {
        
    }
}
