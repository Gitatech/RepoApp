//
//  String+Ex.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 15.04.21.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
