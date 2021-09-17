//
//  RARepositoriesDetailsViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//
import UIKit

class RARepositoriesDetailsViewController: RABaseViewController {
    // MARK: - GUI Variables
    private lazy var contentView = RARepoDetailsView()

    // MARK: - Initialization
    override func initController() {
        super.initController()

        self.controllerTitle = "Details".localized()

        self.mainView.addSubview(self.contentView)
        self.constraints()
    }

    // MARK: - Constraits
    func constraints() {
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }

    // MARK: - Setters
    func setView(with model: RARepoViewModel) {
        self.contentView.setImage(urlString: model.ownerAvatar)
        self.contentView.set(with: model)
    }
}
