//
//  UIFont+Ex.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

extension UIFont {
    // MARK: - Enumerations
    enum RAFontType {
        /// System Font Medium 32px
        case largeTitleMedium
        
        /// System Font Regular 18px
        case regularRegular
        
        /// System Font Regular 16px
        case smallRegular
    }
    
    /**
     Creates UIFont object with given font type
     - Parameter type: Font type.
     - Returns: A UIFont object.
     */
    static func font(ofType type: RAFontType) -> UIFont {
        switch type {
        case .largeTitleMedium:
            return .systemFont(ofSize: 32, weight: .medium)
        case .regularRegular:
            return .systemFont(ofSize: 18, weight: .regular)
        case .smallRegular:
            return .systemFont(ofSize: 16, weight: .regular)
        }
    }
}
