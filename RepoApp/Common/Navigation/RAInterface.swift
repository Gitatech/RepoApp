//
//  RAInterface.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RAInterface {
    // MARK: - Variables
    private weak var window: UIWindow?

    private var navController = UINavigationController()

    // MARK: - Static Properties
    static let shared = RAInterface()

    // MARK: - Initialization
    private init() { }

    // MARK: - Setter
    func setupNavigationController(_ window: UIWindow) {
        self.navController.viewControllers = [RAListViewController()]

        window.rootViewController = self.navController
        window.makeKeyAndVisible()
    }

    // MARK: - Routing
    func pushVC(_ viewController: UIViewController, animated: Bool = true) {
        self.navController.pushViewController(viewController, animated: animated)
    }
}

