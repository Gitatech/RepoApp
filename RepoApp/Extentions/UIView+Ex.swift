//
//  UIView+Ex.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { eachView in
            self.addSubview(eachView)
        }
    }

    func removeSubviews() {
        self.subviews.forEach({$0.removeFromSuperview()})
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath

        self.layer.mask = mask
    }

    /// adds view into new view applying edgeInsets
    func injectedIntoContainerWith(edgeInsets: UIEdgeInsets) -> UIView {
        let view = RAView()
        view.addSubview(self)

        self.snp.makeConstraints { (make) in
            make.edges.equalTo(edgeInsets)
        }

        return view
    }
}
