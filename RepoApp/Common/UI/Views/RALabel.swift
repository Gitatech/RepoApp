//
//  RALabel.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RALabel: UILabel {
    // MARK: - Variables
    var textContainerInset: UIEdgeInsets = .zero {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var labelTextColor: UIColor? {
        didSet {
            guard let color = self.labelTextColor else { return }
            self.textColor = color
        }
    }

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {}

    // MARK: - setter
    func set(text: String?, fontType: UIFont.RAFontType = .regularRegular) {
        self.set(text: text, font: .font(ofType: fontType))
    }

    func set(text: String?, font: UIFont) {
        self.text = text
        self.font = font
    }
}
