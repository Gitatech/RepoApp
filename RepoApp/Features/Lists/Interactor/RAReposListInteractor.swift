//
//  RAReposListInteractor.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

enum RAReposListSuccess {
    case github([RARepoGithubResponseModel])
    case bitbucket(RARepoBitucketResponseModel)
}

enum RAReposListError {
    case typeCasting
    case server(RANetworkError)
}

class RAReposListInteractor: RABaseInteractor<RAReposListSuccess, RAReposListError> {
    // MARK: - Enumerations
    enum RAReposListRequestType {
        case github
        case bitbucket

        var urlPath: String {
            switch self {
            case .github:
                return "repositories"
            case .bitbucket:
                return "2.0/repositories"
            }
        }
    }

    enum FieldsValue: String, CaseIterable {
        case name = "values.name"
        case owner = "values.owner"
        case description = "values.description"
    }

    // MARK: - Variables
    private var querryValue: String {
        var result: String = ""
        RAReposListInteractor.FieldsValue.allCases.forEach {
            result += result.isEmpty ? $0.rawValue : "," + $0.rawValue
        }

        return result
    }

    // MARK: - Request
    func request(with type: RAReposListRequestType) {
        switch type {
        case .github:
            RANetworking.shared.requestAlamofire(
                base: .github,
                url: type.urlPath,
                successHandler: { [weak self] (model: [RARepoGithubResponseModel]) in
                    self?.handle(response: model, type: type)
                },
                errorHandler: { [weak self] error in
                    self?.errorHandler(.server(error))
                })
        case .bitbucket:
            RANetworking.shared.requestAlamofire(
                base: .bitbucket,
                url: type.urlPath,
                parameters: ["fields": self.querryValue],
                successHandler: { [weak self] (model: RARepoBitucketResponseModel) in
                    self?.handle(response: model, type: type)
                },
                errorHandler: { [weak self] error in
                    self?.errorHandler(.server(error))
                })
        }
    }

    // MARK: - Response
    private func handle<Generic>(response: Generic, type: RAReposListRequestType) {
        switch type {
        case .github:
            guard let responseModel = response as? [RARepoGithubResponseModel] else {
                self.errorHandler(.typeCasting)
                return
            }
            self.successHandler(.github(responseModel))
        case .bitbucket:
            guard let responseModel = response as? RARepoBitucketResponseModel else {
                self.errorHandler(.typeCasting)
                return
            }
            self.successHandler(.bitbucket(responseModel))
        }
    }
}
