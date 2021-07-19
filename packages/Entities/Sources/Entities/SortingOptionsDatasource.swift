//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

public struct SortingOptionsDatasource: Equatable {
    public let option: String
    public let isSelected: Bool
    
    public init(
        option: String,
        isSelected: Bool
    ) {
        self.option = option
        self.isSelected = isSelected
    }
}
