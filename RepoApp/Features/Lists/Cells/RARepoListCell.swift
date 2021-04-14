//
//  RARepoListCell.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RARepoListCell: RATableViewCell {
    // MARK: - Variables
    private lazy var edgeInsets = UIEdgeInsets(all: 5)
    private let imageSize = CGSize(width: 48, height: 48)

    private let imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 12)
    private let textEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)

    private let contentColor = UIColor(named: "contentRed")
    private let bgColor = UIColor(named: "descriptionColor")

    // MARK: - GUI Variables
    private(set) lazy var mainView: RAIconTitleDescriptionView = {
        let view = RAIconTitleDescriptionView()
        view.imageView.cornerRadius = self.imageSize.height / 2
        view.imageSize = self.imageSize
        view.imageInsets = self.imageEdgeInsets
        view.titleDescriptionView.edgeInsets = self.textEdgeInsets
        view.backgroundColor = self.contentColor

        return view
    }()

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.contentView.addSubview(self.mainView)
    }

    // MARK: - Constraints
    override func constraints() {
        super.constraints()

        self.mainView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(self.edgeInsets)
        }
    }

    // MARK: - Setter
    func set(title: String, description: String, type: RARepoViewModel.RARepoType) {
        self.mainView.set(title: title, description: description, type: type)

        self.setNeedsUpdateConstraints()
    }

    // MARK: - Images
    func setIcon(iconUrl: String?) {
        if let url = iconUrl {
            self.mainView.imageView.backgroundColor = .clear
            self.mainView.imageView.setImage(with: url) { [weak self] success in
                guard let self = self, !success else { return }
                self.mainView.imageView.backgroundColor = self.bgColor
            }
        } else {
            self.mainView.imageView.backgroundColor = self.bgColor
        }
    }

    // MARK: - TODO
    override func prepareForReuse() {
        super.prepareForReuse()

        self.mainView.resetView()
    }
}
