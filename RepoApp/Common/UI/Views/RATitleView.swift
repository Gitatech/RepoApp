//
//  RATitleView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RATitleView: RALabel {
    // MARK: - Variables
    private let textEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.textContainerInset = self.textEdgeInsets
        self.labelTextColor = UIColor(customColor: .titleColor)

        self.font = .font(ofType: .largeTitleMedium)

        self.numberOfLines = 0
        self.textAlignment = .center
    }
}
