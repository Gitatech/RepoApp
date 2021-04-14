//
//  RAListViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 12.04.21.
//

import UIKit
import RxSwift
import RxCocoa

class RAListViewController: RABaseViewController {
    // MARK: - Variables
    private let edgeInsets = UIEdgeInsets(top: 16, left: 48, bottom: 16, right: 48)

    private let disposeBag = DisposeBag()

    var defaultModels: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    var models: BehaviorRelay<[String]> = BehaviorRelay(value: [])

    // MARK: - GUI Variables
    private lazy var tableView: UITableView = {
        let table = UITableView ()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false

        table.register(RARepoListCell.self,
                       forCellReuseIdentifier: RARepoListCell.identifier)
        table.tableFooterView = UIView()

        return table
    }()

    private lazy var errorView: RAEmptyListView = {
        let view = RAEmptyListView()
        view.isHidden = true
        view.setImage(imageName: "empty_folder", alpha: 0.1)
        view.setDescription("No repositopries here")

        return view
    }()

    // MARK: - Life Cicle
    override func singleDidAppear() {
        super.singleDidAppear()

        // TODO: - Start requests + Dispatch group + Remove next line
        Swift.debugPrint("Start flow")

        self.models.accept(["user3", "user2", "user1"])
        self.defaultModels.accept(["username1", "username2", "username3"])
    }

    // MARK: - Initialization
    override func initController() {
        super.initController()

        self.setContentScrolling(isEnabled: false)
        self.controllerTitle = "Repositories"

        self.mainView.addSubviews([
            self.tableView,
            self.errorView
        ])

        self.bindViewsToViewModel()

        self.constraints()
    }

    // MARK: - Constraints
    private func constraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.errorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
    }

    // MARK: - RX Binding
    private func bindViewsToViewModel() {
        self.models
            .asObservable()
            .bind(to: self.tableView.rx.items(
                    cellIdentifier: RARepoListCell.identifier,
                    cellType: RARepoListCell.self)) { row, notification, cell in
                cell.set(title: self.models.value[row],
                         description: "Username")
                cell.setIcon(iconUrl: nil)
            }.disposed(by: self.disposeBag)

        self.tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { item in

                let model = RARepoViewModel(
                    name: "RepoTest",
                    username: "Igor",
                    avatar: nil,
                    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                let controller = RARepositoriesDetailsViewController()
                controller.setView(with: model)
                RAInterface.shared.push(vc: controller)
            }).disposed(by: self.disposeBag)
    }

    private func sortObservableArray() {
        self.models.value.forEach { print($0) }

        print("===")

        self.models
            .asObservable()
            .map { items -> [String] in
                return items.sorted(by: <)
            }
            .bind(onNext: { items in
                items.forEach { print($0) }
            })
            .disposed(by: self.disposeBag)
    }
}
