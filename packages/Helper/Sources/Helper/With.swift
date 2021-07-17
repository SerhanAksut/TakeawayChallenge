//
//  File.swift
//  
//
//  Created by Serhan Aksut on 17.07.2021.
//

@inlinable
public func with<T>(
    _ subject: T,
    _ transform: (_ subject: inout T) throws -> Void
) rethrows -> T {
    var subject = subject
    try transform(&subject)
    return subject
}
