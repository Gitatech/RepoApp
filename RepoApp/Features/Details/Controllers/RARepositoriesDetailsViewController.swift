//
//  RARepositoriesDetailsViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//
import UIKit

class RARepositoriesDetailsViewController: RABaseViewController {
    // MARK: - Variables

    // MARK: - GUI Variables
    private lazy var contentView: RARepoDetailsView = {
        let view = RARepoDetailsView()
        // TODO: - Add properties

        return view
    }()

    // MARK: - Initialization
    override func initController() {
        super.initController()

        self.controllerTitle = "Details"

        self.mainView.addSubview(self.contentView)
        self.constraints()
    }

    // MARK: - Constraits
    func constraints() {
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(UIEdgeInsets(all: 16))
            make.left.right.bottom.equalToSuperview()
        }
    }

    // MARK: - Setters
    func setView(with model: RARepoViewModel) {
        self.contentView.setImage(image: nil)
        self.contentView.set(with: model)
    }
}
