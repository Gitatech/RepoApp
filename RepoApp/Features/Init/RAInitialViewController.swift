//
//  AMInitialViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RAInitialViewController: RABaseViewController {
    // MARK: - Presenter
    private var presenter: RARepositoriesPresenter?

    // MARK: - Initialization
    override func initController() {
        super.initController()

        self.presenter = RARepositoriesPresenter()
    }
}
