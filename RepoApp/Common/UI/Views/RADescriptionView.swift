//
//  RADescriptionView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RADescriptionView: RALabel {
    // MARK: - Variables
    private let textEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    private let descriptionColor = UIColor(named: "descriptionColor")

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.textContainerInset = self.textEdgeInsets

        self.labelTextColor = self.descriptionColor
        self.font = .font(ofType: .regularRegular)

        self.numberOfLines = 0
        self.textAlignment = .center
    }

    // MARK: - Setters
    override func set(text: String?, fontType: UIFont.RAFontType = .regularRegular) {
        super.set(text: text, fontType: fontType)
    }

    // MARK: - clear
    func clear() {
        self.text = ""
    }
}
