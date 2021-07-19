//
//  File.swift
//  
//
//  Created by Serhan Aksut on 19.07.2021.
//

import UIKit

public extension UIColor {
    convenience init(displayP3red red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        
        self.init(displayP3Red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    convenience init(displayP3Hex hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            displayP3red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}

// MARK: - App Colors
public extension UIColor {
    static let appOrangeColor = UIColor(displayP3Hex: 0xFF8002)
}
