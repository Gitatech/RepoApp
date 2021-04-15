//
//  RANetworkError.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

enum RANetworkError: Error {
    case incorrectUrl
    case networkError(error: Error)
    case serverError(statusCode: Int)
    case parsingError(error: Error)
    case badRequestError
    case unknown
}
