//
//  RADefaultsManager.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

import Foundation

class DefaultsManager {
    // MARK: - Static properties
    static let shared = DefaultsManager()

    // MARK: - Variables
    private let defaults = UserDefaults.standard
    private let udRepositoriesCacheKey: String = "udRepositoriesCacheKey"

    // MARK: - Methods
    @discardableResult
    func writeDataToUD(model: [RARepoViewModel]) -> Bool {
        guard let data = try? JSONEncoder().encode(model) else {
            Swift.debugPrint("UserDefaults writing data error")
            return false
        }
        self.defaults.setValue(data, forKey: self.udRepositoriesCacheKey)
        return true
    }

    func readDataFromUD() -> [RARepoViewModel]? {
        guard let data = self.defaults.data(forKey: self.udRepositoriesCacheKey) else {
            Swift.debugPrint("UserDefaults reading data error")
            return nil
        }
        return try? JSONDecoder().decode(Array<RARepoViewModel>.self, from: data)
    }
}

