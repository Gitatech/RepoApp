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

    var defaultModels: BehaviorRelay<[RARepoViewModel]> = BehaviorRelay(value: [])
    var models: BehaviorRelay<[RARepoViewModel]> = BehaviorRelay(value: [])

    // MARK: - Interactor
    private lazy var interactor = RAReposListInteractor(
        successHandler: { [weak self] success in
            self?.handleSuccessResponse(success: success)
        },
        errorHandler: { [weak self] error in
            self?.handleErrorResponse(error: error)
        })

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
        view.setDescription("No repositories here")

        return view
    }()

    // MARK: - Life Cicle
    override func singleDidAppear() {
        super.singleDidAppear()

        self.interactor.request(with: .github)
        self.interactor.request(with: .bitbucket)
    }

    // MARK: - Initialization
    override func initController() {
        super.initController()

        self.setContentScrolling(isEnabled: false)
        self.setupNavigationBar()

        self.mainView.addSubviews([
            self.tableView,
            self.errorView
        ])

        self.bindViewsToViewModel()
        self.showEmptyView()

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

    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.controllerTitle = "Repositories"

        let sortingItem = UIBarButtonItem(
            title: "Sorting",
            image: nil,
            primaryAction: nil,
            menu: UIMenu(
                title: "",
                children: [
                    UIAction(title: "A → Z") { [weak self] _ in
                        guard let self = self else { return }
                        self.models.accept(self.models.value.sorted(by: { $0.repoName < $1.repoName }))
                    },
                    UIAction(title: "Z ← A") { [weak self] _ in
                        guard let self = self else { return }
                        self.models.accept(self.models.value.sorted(by: { $0.repoName > $1.repoName }))
                    },
                    UIAction(title: "Reset") { [weak self] _ in
                        guard let self = self else { return }
                        self.models.accept(self.defaultModels.value)
                    }
                ]))
        self.navigationItem.rightBarButtonItem = sortingItem
    }

    // MARK: - Handlers
    private func handleSuccessResponse(success: RAReposListSuccess) {
        switch success {
        case .github(let model):
            self.models.accept(self.parseResponseModels(responseModel: model) + self.models.value)
            self.defaultModels.accept(self.models.value)
        case .bitbucket(let model):
            self.models.accept(self.parseResponseModels(responseModel: model) + self.models.value)
            self.defaultModels.accept(self.models.value)
        }
    }

    private func handleErrorResponse(error: RAReposListError) {
        switch error {
        case .typeCasting:
            Swift.debugPrint("type casting")
        case .server(let error):
            Swift.debugPrint(error.localizedDescription)
        }
    }

    // MARK: - Parsing
    private func parseResponseModels<Generic: Decodable>(responseModel: Generic) -> [RARepoViewModel] {
        var repoArray: [RARepoViewModel] = []
        if let model = responseModel as? [RARepoGithubResponseModel] {
            model.forEach {
                repoArray.append(RARepoViewModel(
                                    name: $0.repositoryName,
                                    username: $0.owner.login,
                                    avatar: $0.owner.avatarUrl,
                                    description: $0.repositoryDescription,
                                    type: .github))
            }
        } else if let model = responseModel as? RARepoBitucketResponseModel {
            model.values.forEach {
                repoArray.append(RARepoViewModel(
                                    name: $0.name,
                                    username: $0.owner.nickname ?? "Undefined",
                                    avatar: $0.owner.links.avatar.avatarLink,
                                    description: $0.description,
                                    type: .bitbucket))
            }
        }

        return repoArray
    }
}

// MARK: - RX Binding
extension RAListViewController {
    func bindViewsToViewModel() {
        self.models
            .asObservable()
            .bind(to: self.tableView.rx.items(
                    cellIdentifier: RARepoListCell.identifier,
                    cellType: RARepoListCell.self)) { row, element, cell in
                cell.set(title: element.username,
                         description: element.repoName,
                         type: element.repoType)
            }.disposed(by: self.disposeBag)

        self.tableView.rx.modelSelected(RARepoViewModel.self)
            .subscribe(onNext: { item in
                let controller = RARepositoriesDetailsViewController()
                controller.setView(with: item)
                RAInterface.shared.pushVC(controller, animated: true)
            }).disposed(by: self.disposeBag)
    }

    func showEmptyView() {
        self.models
            .asObservable()
            .subscribe { (_) in
                self.errorView.isHidden = !self.models.value.isEmpty
                self.navigationItem.rightBarButtonItem?.isEnabled = !self.models.value.isEmpty
            }.disposed(by: self.disposeBag)
    }
}
