//
//  RAAlertManager.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

import UIKit

class RAAlertManager {
    // MARK: - Static
    static let shared = RAAlertManager()

    // MARK: - Variables
    private var isShowed: Bool = false

    // MARK: - Initialization
    private init() { }

    // MARK: - Methods
    func show(title: String = "",
              message: String = "",
              leftButtonTitle: String? = nil,
              rightButtonTitle: String,
              leftButtonAction: (() -> Void)? = nil,
              rightButtonAction: (() -> Void)?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              var topController = appDelegate.window?.rootViewController,
              !self.isShowed else { return }
        self.isShowed = true

        while let controller = topController.presentedViewController {
            topController = controller
            topController.view.backgroundColor = .white
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let leftTitle = leftButtonTitle {
            alert.addAction(UIAlertAction(
                                title: leftTitle,
                                style: .cancel,
                                handler: { [weak self] (_) in
                                    self?.isShowed = false
                                    leftButtonAction?()
                                }))
        }
        alert.addAction(UIAlertAction(
                            title: rightButtonTitle,
                            style: .destructive,
                            handler: { [weak self] (_) in
                                self?.isShowed = false
                                rightButtonAction?()
                            }))

        topController.present(alert, animated: true)
    }
}
