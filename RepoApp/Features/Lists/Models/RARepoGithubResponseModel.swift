//
//  RARepoGithubResponseModel.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

struct RARepoGithubResponseModel: Decodable {
    let repositoryName: String
    let fullRepositoryName: String
    let owner: RAGihubOwner
    let repositoryDescription: String?

    enum CodingKeys: String, CodingKey {
        case repositoryName = "name"
        case fullRepositoryName = "full_name"
        case owner
        case repositoryDescription = "description"
    }
}

struct RAGihubOwner: Decodable {
    let login: String
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login = "login"
    }
}
