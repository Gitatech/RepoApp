//
//  RARepositoriesPresenter.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import Foundation

// TODO: - Remove if needed
class RARepositoriesPresenter {
    // MARK: - Models
    private var viewModel: RARepoViewModel?

    // MARK: - Interactor

    // MARK: - Controllers
    private(set) var listController: RAListViewController?
    private(set) var detailsController: RARepositoriesDetailsViewController?

    // MARK: - Actions
    func startFlow() {
        /*...*/
        
    }

    // MARK: - Handling
}

// MARK: - Routing
extension RARepositoriesPresenter {
    private func presentListViewController() { /*...*/ }
    private func presentDetailsViewController() { /*...*/ }
}
