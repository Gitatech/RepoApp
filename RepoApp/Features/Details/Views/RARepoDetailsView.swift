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
    private let markerEdgeInsets = UIEdgeInsets(all: 4)

    private let marlerSize = CGSize(width: 10, height: 10)

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

    private lazy var markerView = RAView()

    private lazy var profileView: RATitleDescriptionView = {
        let view = RATitleDescriptionView()
        view.textAlignment = .center

        return view
    }()

    private lazy var descriptionView = RADescriptionView()

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.add([
            self.avatarView.injectedIntoContainerWith(edgeInsets: UIEdgeInsets(all: 24)),
            self.profileView.injectedIntoContainerWith(edgeInsets: self.contentEdgeInsets),
            self.descriptionView.injectedIntoContainerWith(edgeInsets: self.contentEdgeInsets)
        ])
        self.setMarker()
    }

    // MARK: - Methods
    func setMarker() {
        self.avatarView.imageView.addSubview(self.markerView)
        self.markerView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(self.markerEdgeInsets)
            make.size.equalTo(self.marlerSize)
        }
    }

    // MARK: - Setters
    func setImage(urlString: String?) {
        if let url = urlString {
            self.avatarView.imageView.backgroundColor = .clear
            self.avatarView.setImage(with: url) { [weak self] success in
                guard let self = self, !success else { return }
                self.avatarView.imageView.backgroundColor = UIColor(customColor: .descriptionColor)
            }
        } else {
            self.avatarView.imageView.backgroundColor = UIColor(customColor: .descriptionColor)
        }
    }

    func set(with model: RARepoViewModel) {
        self.profileView.set(title: model.username,
                             description: model.repoName)
        self.descriptionView.set(text: model.repoDescription,
                                 fontType: .smallRegular)
        self.markerView.backgroundColor = model.repoType == .bitbucket ? .systemGreen  : .clear

        self.setNeedsUpdateConstraints()
    }
}
