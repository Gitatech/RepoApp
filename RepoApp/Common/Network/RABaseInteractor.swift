//
//  RABaseInteractor.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

class RABaseInteractor<S, E> {
    // MARK: - Typealiases
    typealias Success = (S) -> Void
    typealias Error = (E) -> Void

    // MARK: - Variables
    private(set) var successHandler: Success
    private(set) var errorHandler: Error

    // MARK: - Initialization
    init(successHandler: @escaping Success,
         errorHandler: @escaping Error) {
        self.successHandler = successHandler
        self.errorHandler = errorHandler
    }
}
