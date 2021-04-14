//
//  RARepoBitbucketResponseModel.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 14.04.21.
//

struct RARepoBitucketResponseModel: Decodable {
    let values: [RARepoValues]
}

struct RARepoValues: Decodable {
    let owner: RABitbucketOwner
    let name: String
    let description: String?
}

struct RABitbucketOwner: Decodable {
    let displayName: String
    let nickname: String?
    let username: String?
    let links: RABitbucketOwnerLinks

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case nickname, username
        case links
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.links = try container.decode(RABitbucketOwnerLinks.self, forKey: .links)
    }
}

struct RABitbucketOwnerLinks: Decodable {
    let avatar: RABitbucketOwnerAvatarLink
}

struct RABitbucketOwnerAvatarLink: Decodable {
    let avatarLink: String?

    enum CodingKeys: String, CodingKey {
        case avatarLink = "href"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.avatarLink = try? container.decodeIfPresent(String.self, forKey: .avatarLink)
    }
}


