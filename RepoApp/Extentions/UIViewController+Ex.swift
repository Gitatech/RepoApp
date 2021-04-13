//
//  UIViewController+Ex.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

extension UIViewController {
    func pushVC(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func push(vc: UIViewController,
              animated: Bool = true,
              completion: (() -> Void)?) {
        guard let navigationController = self.navigationController else {
            completion?()
            return
        }
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.pushViewController(vc, animated: animated)
            CATransaction.commit()
        } else {
            navigationController.pushViewController(vc, animated: animated)
            completion?()
        }
    }

    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }

    func popVC(animated: Bool,
               completion: (() -> Void)?) {
        guard let navigationController = self.navigationController else {
            completion?()
            return
        }
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.popViewController(animated: animated)
            CATransaction.commit()
        } else {
            navigationController.popViewController(animated: animated)
            completion?()
        }
    }

    func presentVC(_ vc: UIViewController,
                   animated: Bool = true,
                   completion: (() -> Void)? = nil) {
        self.present(vc, animated: animated, completion: completion)
    }

    func dismissVC(animated: Bool = true,
                   completion: (() -> Void)? ) {
        self.dismiss(animated: animated, completion: completion)
    }
}
