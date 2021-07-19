//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import UIKit

public extension UINavigationController {
    func configure() {
        navigationBar.barTintColor = .appOrangeColor
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
        ]
        navigationBar.titleTextAttributes = attributes
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
