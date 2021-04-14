//
//  RATitleView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RATitleView: RALabel {
    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        self.labelTextColor = .black

        self.font = .font(ofType: .largeTitleMedium)

        self.numberOfLines = 0
        self.textAlignment = .center
    }

    // MARK: - Setters
    override func set(text: String?,
                      fontType: UIFont.RAFontType = .largeTitleMedium) {
        super.set(text: text, fontType: fontType)
    }
}
