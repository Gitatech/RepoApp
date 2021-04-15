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
}

struct RABitbucketOwnerLinks: Decodable {
    let avatar: RABitbucketOwnerAvatarLink
}

struct RABitbucketOwnerAvatarLink: Decodable {
    let avatarLink: String?

    enum CodingKeys: String, CodingKey {
        case avatarLink = "href"
    }
}


