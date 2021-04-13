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
    func presentVC(_ vc: UIViewController, animated: Bool = true) {
        self.navController.present(vc, animated: animated, completion: nil)
    }

    func dismissVC(animated: Bool = true, completion: (() -> Void)? = nil) {
        self.navController.dismissVC(animated: animated, completion: completion)
    }

    func pushVC(_ viewController: UIViewController, animated: Bool = true) {
        self.navController.pushViewController(viewController, animated: animated)
    }

    func popVC() {
        self.navController.popViewController(animated: true)
    }

    func popToVC(_ vc: UIViewController, animated: Bool = true) {
        self.navController.popToViewController(vc, animated: animated)
    }

    func popVC(_ viewControllers: [UIViewController]) {
        let controllers = self.navController.viewControllers.filter { !viewControllers.contains($0) }
        self.setVC(controllers)
    }

    func setVC(_ viewControllers: [UIViewController]) {
        self.navController.setViewControllers(viewControllers, animated: true)
    }
}

extension RAInterface {
    func push(vc: UIViewController) {
        self.navController.pushViewController(vc, animated: false)
    }

    func popVC(completion: (() -> Void)? = nil) {
        self.navController.popViewController(animated: false)
    }
}

