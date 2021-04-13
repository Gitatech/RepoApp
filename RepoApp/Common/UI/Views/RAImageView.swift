//
//  RAImageView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit
import Kingfisher

class RAImageView: RAView {
    // MARK: - UIImageView properties
    var isRectangle: Bool = true {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }

    var imageContentMode: UIView.ContentMode = .scaleToFill {
        didSet {
            self.imageView.layer.masksToBounds = true
            self.imageView.contentMode = self.imageContentMode
        }
    }

    var imageCornerRadius: CGFloat? {
        didSet {
            self.imageView.layer.cornerRadius = self.imageCornerRadius ?? 0
            self.imageView.layer.masksToBounds = self.imageCornerRadius != nil
        }
    }

    var imageSize: CGSize? {
        didSet {
            self.isRectangle = false
            self.setNeedsUpdateConstraints()
        }
    }

    var imageBackgroundColor: UIColor? {
        didSet {
            self.imageView.backgroundColor = self.imageBackgroundColor
        }
    }

    // MARK: - Image corners
    var cornerRadius: CGFloat? = nil {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    var corners: UIRectCorner = [UIRectCorner.allCorners] {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    // MARK: - GUI Variable
    private(set) var imageView = UIImageView()

    // MARK: - Initialization
    override func initView() {
        super.initView()

        self.addSubview(self.imageView)
        self.imageContentMode = .scaleToFill
    }

    // MARK: - Constraints
    override func constraints() {
        super.constraints()

        self.imageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.top.left.greaterThanOrEqualToSuperview()
            make.right.bottom.lessThanOrEqualToSuperview()

            if let imageSize = self.imageSize {
                make.size.equalTo(imageSize)
            } else {
                make.width.equalToSuperview()
                if self.isRectangle {
                    make.height.equalTo(self.imageView.snp.width)
                } else {
                    make.height.equalToSuperview()
                }
            }
        }
    }

    // MARK: - LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsUpdateConstraints()

        if let radius = self.cornerRadius {
            self.roundCorners(self.corners, radius: radius)
        }
    }

    // MARK: - Setter
    func setImage(name: String) {
        self.imageView.image = UIImage(named: name)
    }

    // MARK: - Image loading
    func cancelImageLoading() {
        self.imageView.kf.cancelDownloadTask()
    }

    // MARK: - Internal methods
    func clearImage() {
        self.imageSize = nil
        self.imageView.image = nil
    }
}
