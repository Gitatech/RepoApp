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
        /// System Font Regular 36px
        case xLargeRegular

        /// System Font Medium 32px
        case largeTitleMedium

        /// System Font Regular 32px
        case largeTitleRegular

        /// System Font Semibold 18px
        case regularSemibold

        /// System Font Regular 18px
        case regularRegular

        /// System Font Semibold 16px
        case smallSemibold

        /// System Font Regular 16px
        case smallRegular

        /// System Font Regular 14px
        case xSmallRegular
    }

    /**
     Creates UIFont object with given font type
     - Parameter type: Font type.
     - Returns: A UIFont object.
     */
    static func font(ofType type: RAFontType) -> UIFont {
        switch type {
        case .xLargeRegular:
            return .systemFont(ofSize: 36, weight: .regular)
        case .largeTitleMedium:
            return .systemFont(ofSize: 32, weight: .medium)
        case .largeTitleRegular:
            return .systemFont(ofSize: 32, weight: .regular)
        case .regularSemibold:
            return .systemFont(ofSize: 18, weight: .semibold)
        case .regularRegular:
            return .systemFont(ofSize: 18, weight: .regular)
        case .smallSemibold:
            return .systemFont(ofSize: 16, weight: .semibold)
        case .smallRegular:
            return .systemFont(ofSize: 16, weight: .regular)
        case .xSmallRegular:
            return .systemFont(ofSize: 14, weight: .regular)
        }
    }
}
