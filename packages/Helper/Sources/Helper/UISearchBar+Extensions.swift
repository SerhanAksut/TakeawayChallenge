//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit

public extension UISearchBar {
    var textField: UITextField? {
        value(forKey: "searchField") as? UITextField
    }
}
