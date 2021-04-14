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

    // MARK: - Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.repoName, forKey: .repoName)
        try container.encode(self.username, forKey: .username)
        try container.encode(self.ownerAvatar, forKey: .ownerAvatar)
        try container.encode(self.repoDescription, forKey: .repoDescription)
        try container.encode(self.repoType, forKey: .repoType)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.repoName = try container.decode(String.self, forKey: .repoName)
        self.username = try container.decode(String.self, forKey: .username)
        self.ownerAvatar = try? container.decodeIfPresent(String.self, forKey: .ownerAvatar)
        self.repoDescription = try? container.decodeIfPresent(String.self, forKey: .repoDescription)
        self.repoType = try container.decode(RARepoType.self, forKey: .repoType)
    }
}
