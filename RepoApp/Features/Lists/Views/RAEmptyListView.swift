//
//  RAEmptyListView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RAEmptyListView: RAViewWithStackView {
    // MARK: - Variables
    private let descriptionInsets = UIEdgeInsets(all: 16)

    var defaultImageSize = CGSize(width: 175, height: 175) {
        didSet {
            self.imageView.imageSize = self.defaultImageSize
        }
    }

    // MARK: - GUI Variables
    private lazy var imageView = RAImageView()

    private(set) lazy var descriptionView: RADescriptionView = {
        let view = RADescriptionView()
        view.font = .font(ofType: .smallRegular)
        view.isHidden = true

        return view
    }()

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.add(self.imageView)
        self.add(self.descriptionView.injectedIntoContainerWith(edgeInsets: self.descriptionInsets))
    }

    // MARK: - Setters
    func setImage(imageName: String, alpha: CGFloat = 1) {
        self.imageView.setImage(name: imageName)
        self.imageView.imageSize = self.defaultImageSize
        self.imageView.alpha = alpha
    }

    func setDescription(_ text: String) {
        self.descriptionView.isHidden = false
        self.descriptionView.set(text: text, font: .font(ofType: .smallRegular))
    }
}
