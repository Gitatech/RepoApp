//
//  RARepoDetailsView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

import UIKit


class RARepoDetailsView: RAViewWithStackView {
    // MARK: - Variables
    private let contentEdgeInsets = UIEdgeInsets(all: 16)

    var defaultImageSize = CGSize(width: 250, height: 250) {
        didSet {
            self.avatarView.imageSize = self.defaultImageSize
        }
    }

    // MARK: - GUI Variables
    private lazy var avatarView: RAImageView = {
        let imageView = RAImageView()
        imageView.clipsToBounds = true
        imageView.imageSize = self.defaultImageSize

        return imageView
    }()

    private lazy var profileView: RATitleDescriptionView = {
        let view = RATitleDescriptionView()
        view.textAlignment = .center

        return view
    }()

    private lazy var descriptionView: RADescriptionView = {
        let view = RADescriptionView()
        view.font = .font(ofType: .smallRegular)

        return view
    }()

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.add([
            self.avatarView.injectedIntoContainerWith(edgeInsets: UIEdgeInsets(all: 24)),
            self.profileView.injectedIntoContainerWith(edgeInsets: self.contentEdgeInsets),
            self.descriptionView.injectedIntoContainerWith(edgeInsets: self.contentEdgeInsets)
        ])
    }

    // MARK: - Setters
    func setImage(urlString: String?) {
        if let url = urlString {
            self.avatarView.imageView.backgroundColor = .clear
            self.avatarView.setImage(with: url) { [weak self] success in
                guard let self = self else { return }
                self.avatarView.imageView.backgroundColor = .darkGray
            }
        } else {
            self.avatarView.imageView.backgroundColor = .darkGray
        }
    }

    func set(with model: RARepoViewModel) {
        self.profileView.set(title: model.repoName,
                             description: model.username)
        self.descriptionView.set(text: model.repoDescription)

        self.setNeedsUpdateConstraints()
    }
}
