//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit

public extension UIViewController {
    func addChildController<T: UIViewController>(
        controller: T,
        viewHandler: ((UIView) -> Void)
    ) {
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        viewHandler(controller.view)
        controller.didMove(toParent: self)
    }
}
