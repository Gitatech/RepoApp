//
//  UIColor+Ex.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 15.04.21.
//

import UIKit

extension UIColor {
    enum RACustomColors: String {
        case accentColor = "AccentColor"
        case background
        case contentRed
        case titleColor
        case descriptionColor
    }

    convenience init?(customColor: RACustomColors) {
        self.init(named: customColor.rawValue)
    }
}
