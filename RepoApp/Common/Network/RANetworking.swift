//
//  RANetworking.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

import Alamofire

class RANetworking {
    // MARK: - Enumerations
    enum RABaseUrl {
        case github
        case bitbucket

        var baseUrl: String {
            switch self {
            case .github:
                return "https://api.github.com/"
            case .bitbucket:
                return "https://api.bitbucket.org/"
            }
        }
    }

    // MARK: - Static
    static let shared = RANetworking()

    // MARK: - Variables
    private let sessionManager: Alamofire.Session

    private lazy var parameters: [String: String] = [:]

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        self.sessionManager = Session.default
    }

    // MARK: - Requests
    func requestAlamofire<Generic: Decodable>(base: RABaseUrl,
                                              url: String,
                                              parameters: [String: String]? = nil,
                                              successHandler: @escaping (Generic) -> Void,
                                              errorHandler: @escaping (RANetworkError) -> Void) {
        if let isConnectionAvailable = NetworkReachabilityManager()?.isReachable,
           !isConnectionAvailable {
            RAAlertManager.shared.show(
                title: "No connection to the Interner",
                message: "Please, check your device for the connection to the Interner",
                leftButtonTitle: "Cancel",
                rightButtonTitle: "Settings",
                leftButtonAction: nil,
                rightButtonAction: {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                          UIApplication.shared.canOpenURL(settingsUrl) else { return }
                    UIApplication.shared.open(settingsUrl)
                })
            return
        }

        var urlParameters = self.parameters
        if let parameters = parameters {
            parameters.forEach { urlParameters[$0.key] = $0.value }
        }

        guard let fullUrl = self.getUrlWith(url: base.baseUrl,
                                            path: url,
                                            parameters: urlParameters) else {
            errorHandler(.incorrectUrl)
            return
        }

        self.sessionManager
            .request(fullUrl)
            .responseJSON(completionHandler: { (response) in
                if let error = response.error {
                    errorHandler(.networkError(error: error))
                    return
                } else if let data = response.data,
                          let httpResponse = response.response {
                    switch httpResponse.statusCode {
                    case 200..<300:
                        do {
                            let model = try JSONDecoder().decode(Generic.self, from: data)
                            successHandler(model)
                        } catch let error {
                            errorHandler(.parsingError(error: error))
                        }
                    case 400..<500:
                        Swift.debugPrint(String(decoding: data, as: UTF8.self))
                        break
                    case 500...:
                        errorHandler(.serverError(statusCode: httpResponse.statusCode))
                    default:
                        errorHandler(.unknown)
                    }
                }
            })
    }
}
