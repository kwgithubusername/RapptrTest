//
//  Extensions.swift
//  Rapptr iOS Test
//
//  Created by Jack on 6/17/22.
//

import Foundation
import UIKit

extension UINavigationController {
    func setNavigationBarColor(_ color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
    }
}
