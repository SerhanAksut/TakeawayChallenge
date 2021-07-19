//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import Foundation

public protocol ViewIdentifier: AnyObject {
    var viewIdentifier: String { get }
    static var viewIdentifier: String { get }
}

public extension ViewIdentifier {
    static var viewIdentifier: String {
        String(describing: self)
    }
    
    var viewIdentifier: String {
        let typeOfSelf = type(of: self)
        return String(describing: typeOfSelf)
    }
}

extension NSObject: ViewIdentifier {}
