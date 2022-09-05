//
//  GithubRepositoryResults.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import Foundation

struct GithubRepositoryResults: Codable {
    let totalCount: Int
    var items: [GithubRepositoryResult]
}

struct GithubRepositoryResult: Codable, Identifiable {
    let id: Int
    let name: String
    let language: String?
    let description: String?
    let stargazersCount: Int
    let owner: Owner?
}

struct Owner: Codable {
    let login: String
    let avatarUrl: String
}
