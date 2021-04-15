//
//  RARepoViewModel.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RARepoViewModel: Codable {
    // MARK: - Enumerations
    enum RARepoType: String, Codable {
        case github = "GitHub"
        case bitbucket = "BitBucket"

        var typeColor: UIColor {
            switch self {
            case .github:
                return .clear
            case .bitbucket:
                return .systemGreen
            }
        }
    }

    // MARK: - Variables
    let repoName: String
    let username: String
    let ownerAvatar: String?
    let repoDescription: String?
    let repoType: RARepoType

    enum CodingKeys: String, CodingKey {
        case repoName = "repositoryName"
        case username = "username"
        case ownerAvatar = "ownerAvatar"
        case repoDescription = "repositoryDescription"
        case repoType = "repositoryType"
    }

    // MARK: - Init
    init(name: String,
         username: String, avatar: String? = nil,
         description: String? = nil,
         type: RARepoType = .bitbucket) {
        self.repoName = name
        self.username = username
        self.ownerAvatar = avatar
        self.repoDescription = description
        self.repoType = type
    }
}
