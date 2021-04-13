//
//  RARepoViewModel.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

class RARepoViewModel {
    // MARK: - Enumerations
    enum RARepoType: String {
        case github = "GitHub"
        case bitbucket = "BitBucket"
    }

    // MARK: - Variables
    let repoName: String
    let username: String
    let ownerAvatar: String?
    let repoDescription: String?

    // MARK: - Init
    init(name: String, username: String, avatar: String? = nil, description: String? = nil) {
        self.repoName = name
        self.username = username
        self.ownerAvatar = avatar
        self.repoDescription = description
    }
}
