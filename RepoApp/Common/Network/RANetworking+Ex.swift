//
//  RANetworking+Ex.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

import Foundation

extension RANetworking {
    func getUrlWith(url: String, path: String,
                    parameters: [String: String]? = nil) -> URL? {
        guard var components = URLComponents(string: url + path) else { return nil }
        if let parameters = parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return components.url
    }
}
