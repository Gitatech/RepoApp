//
//  RAListViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 12.04.21.
//

import UIKit
import RxCocoa

class RAListViewController: RABaseViewController {
    // MARK: - Variables
    private let edgeInsets = UIEdgeInsets(top: 16, left: 48, bottom: 16, right: 48)

    private var dispatchGroup = DispatchGroup()

    private var defaultModels: BehaviorRelay<[RARepoViewModel]> = BehaviorRelay(value: [])
    private var models: BehaviorRelay<[RARepoViewModel]> = BehaviorRelay(value: [])

    private var cache: [RARepoViewModel]? {
        get {
            return DefaultsManager.shared.readDataFromUD()
        }
        set {
            guard let data = newValue else { return }
            DefaultsManager.shared.writeDataToUD(model: data)
        }
    }

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
        view.setDescription("No repositories".localized())

        return view
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor(customColor: .accentColor)
        control.attributedTitle = NSAttributedString(
            string: "Swipe".localized(),
            attributes: [.foregroundColor: UIColor(customColor: .accentColor) ?? .red])

        return control
    }()

    // MARK: - Life Cicle
    override func singleDidAppear() {
        super.singleDidAppear()

        self.loadRepositories()
    }

    // MARK: - Initialization
    override func initController() {
        super.initController()

        self.setContentScrolling(isEnabled: false)

        self.setupNavigationBar()
        self.setupRefreshControl()

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

    // MARK: - Methods
    private func loadRepositories() {
        self.dispatchGroup.enter()
        self.interactor.request(with: .github)

        self.dispatchGroup.enter()
        self.interactor.request(with: .bitbucket)

        self.dispatchGroup.notify(queue: .main) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }

    @objc func refresh() {
        self.loadRepositories()
    }

    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.controllerTitle = "Repositories".localized()

        let sortingItem = UIBarButtonItem(
            title: "Sorting".localized(),
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
                    UIAction(title: "Reset".localized()) { [weak self] _ in
                        guard let self = self else { return }
                        self.models.accept(self.defaultModels.value)
                    }
                ]))
        self.navigationItem.rightBarButtonItem = sortingItem
    }

    // MARK: - Refresh Control
    private func setupRefreshControl() {
        self.refreshControl.addTarget(self,
                                      action: #selector(self.refresh),
                                      for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
    }

    // MARK: - Handlers
    private func handleSuccessResponse(success: RAReposListSuccess) {
        switch success {
        case .github(let model):
            self.setupModel(with: model)
        case .bitbucket(let model):
            self.setupModel(with: model)
        }
    }

    private func handleErrorResponse(error: RAReposListError) {
        switch error {
        case .typeCasting:
            Swift.debugPrint("type casting")
        case .server(let error):
            Swift.debugPrint(error.localizedDescription)
        }

        self.dispatchGroup.leave()

        guard let cache = self.cache else { return }
        self.defaultModels.accept(cache)
        self.models.accept(cache)
    }

    // MARK: - Parsing
    private func setupModel<Generic: Decodable>(with model: Generic) {
        self.dispatchGroup.leave()

        self.models.accept(self.parseResponseModels(responseModel: model) + self.models.value)
        self.defaultModels.accept(self.models.value)
        self.cache = self.defaultModels.value
    }

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
                cell.setIcon(iconUrl: element.ownerAvatar)
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
