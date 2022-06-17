//
//  Extensions.swift
//  Rapptr iOS Test
//
//  Created by Jack on 6/17/22.
//

import Foundation
import UIKit

extension UINavigationController {
    func setNavigationBarBackgroundColor(_ backgroundColor: UIColor, textColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
