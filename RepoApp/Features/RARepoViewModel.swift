//
//  RARepoViewModel.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RARepoViewModel {
    // MARK: - Enumerations
    enum RARepoType: String {
        case github = "GitHub"
        case bitbucket = "BitBucket"

        var typeColor: UIColor {
            switch self {
            case .github:
                return .clear
            case .bitbucket:
                return .yellow
            }
        }
    }

    // MARK: - Variables
    let repoName: String
    let username: String
    let ownerAvatar: String?
    let repoDescription: String?
    let repoType: RARepoType

    // MARK: - Init
    init(name: String, username: String, avatar: String? = nil, description: String? = nil, type: RARepoType = .bitbucket) {
        self.repoName = name
        self.username = username
        self.ownerAvatar = avatar
        self.repoDescription = description
        self.repoType = type
    }
}
