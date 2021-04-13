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
}
