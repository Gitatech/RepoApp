//
//  RAListViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 12.04.21.
//

import UIKit

class RAListViewController: RABaseViewController {

    // MARK: - Variables
    private let edgeInsets = UIEdgeInsets(top: 16, left: 48, bottom: 16, right: 48)

    // MARK: - GUI Variables
    private lazy var errorView: RAEmptyListView = {
        let view = RAEmptyListView()
        view.setImage(imageName: "empty_folder", alpha: 0.1)
        view.setDescription("No repositopries here")

        return view
    }()

    // MARK: - Life Cicle
    override func singleDidAppear() {
        super.singleDidAppear()

        // TODO: - Start requests + Dispatch group + Remove next line
        Swift.debugPrint("Start flow")
    }

    // MARK: - Initialization
    override func initController() {
        super.initController()
        self.setContentScrolling(isEnabled: false)
        self.controllerTitle = "Repositories"

        self.mainView.addSubview(self.errorView)

        self.constraints()
    }

    // MARK: - Constraints
    private func constraints() {
        self.errorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
    }
}

