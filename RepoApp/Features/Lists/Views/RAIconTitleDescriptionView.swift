//
//  RAIconTitleDescriptionView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RAIconTitleDescriptionView: RAView {
    // MARK: - Variables
    var imageSize = CGSize(width: 24, height: 24) {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }

    var imageInsets = UIEdgeInsets.zero {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }

    var markerWidth: CGFloat = 5

    var markerInsets = UIEdgeInsets.zero {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }

    // MARK: - GUI Variables
    private(set) lazy var imageView = RAImageView()

    private(set) lazy var titleDescriptionView: RATitleDescriptionView = {
        let view = RATitleDescriptionView()
        view.textAlignment = .left
        view.titleView.textContainerInset = .zero
        view.descriptionView.textContainerInset = .init(top: 2, left: 0, bottom: 0, right: 0)

        return view
    }()

    private(set) lazy var markerView = RAView()

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.addSubviews([
            self.imageView,
            self.titleDescriptionView,
            self.markerView
        ])
    }

    override func constraints() {
        super.constraints()

        self.imageView.snp.updateConstraints { (make) in
            make.top.greaterThanOrEqualToSuperview().offset(self.imageInsets.top)
            make.left.equalToSuperview().offset(self.imageInsets.left)
            make.bottom.lessThanOrEqualToSuperview().inset(self.imageInsets.bottom)
            make.centerY.equalToSuperview()
            make.size.equalTo(self.imageSize)
        }

        self.titleDescriptionView.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(self.imageView.snp.right).offset(self.imageInsets.right)
        }

        self.markerView.snp.updateConstraints { (make) in
            make.top.greaterThanOrEqualToSuperview().offset(self.markerInsets.top)
            make.left.equalTo(self.titleDescriptionView.snp.right)
            make.right.equalToSuperview().inset(self.markerInsets.right)
            make.bottom.lessThanOrEqualToSuperview().inset(self.markerInsets.bottom)
            make.centerY.equalToSuperview()
            make.width.equalTo(self.markerWidth)
        }
    }

    // MARK: - Setter
    func set(title: String, description: String?,
             type: RARepoViewModel.RARepoType) {
        self.titleDescriptionView.set(title: title, description: description)
        self.markerView.backgroundColor = type.typeColor

        self.setNeedsUpdateConstraints()
    }

    func resetView() {
        self.imageView.cancelImageLoading()
        self.imageView.clearImage()
        self.markerView.backgroundColor = .clear
    }
}
