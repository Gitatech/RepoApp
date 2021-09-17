//
//  RATitleDescriptionView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RATitleDescriptionView: RAViewWithStackView {
    // MARK: - Variables
    var textAlignment: NSTextAlignment = .left {
        didSet {
            self.titleView.textAlignment = self.textAlignment
            self.descriptionView.textAlignment = self.textAlignment
        }
    }

    // MARK: - GUI Variables
    private(set) lazy var titleView = RATitleView()

    private(set) lazy var descriptionView = RADescriptionView()

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.add([
            self.titleView,
            self.descriptionView
        ])
    }

    // MARK: - Setters
    func set(title: String?,
             titleFont: UIFont = .font(ofType: .largeTitleMedium),
             description: String?,
             descriptionFont: UIFont = .font(ofType: .regularRegular)) {
        self.titleView.set(text: title, font: titleFont)
        self.descriptionView.set(text: description, font: descriptionFont)
    }
}
