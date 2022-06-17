//
//  Colors.swift
//  Rapptr iOS Test
//
//  Created by Jack on 6/17/22.
//

import UIKit

struct Colors {
    static let headerBackground = UIColor(rgb: 0x0E5C89)
    static let buttonBlue = UIColor(rgb: 0x0E5C89)
    static let viewBackground = UIColor(rgb: 0xF9F9F9)
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
