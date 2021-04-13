//
//  RAListViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 12.04.21.
//

import UIKit

class RAListViewController: RABaseViewController {
    // MARK: - Life Cicle
    override func singleDidAppear() {
        super.singleDidAppear()

        Swift.debugPrint("Start flow")
    }

    override func initController() {
        super.initController()
        self.setContentScrolling(isEnabled: false)

        self.controllerTitle = "Repositories"
    }
}

