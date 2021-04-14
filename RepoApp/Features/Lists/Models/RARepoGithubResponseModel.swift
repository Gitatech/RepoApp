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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.repositoryName = try container.decode(String.self, forKey: .repositoryName)
        self.fullRepositoryName = try container.decode(String.self, forKey: .fullRepositoryName)
        self.owner = try container.decode(RAGihubOwner.self, forKey: .owner)
        self.repositoryDescription = try? container.decodeIfPresent(String.self, forKey: .repositoryDescription)
    }
}

struct RAGihubOwner: Decodable {
    let login: String
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login = "login"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.login = try container.decode(String.self, forKey: .login)
        self.avatarUrl = try? container.decodeIfPresent(String.self, forKey: .avatarUrl)
    }
}
