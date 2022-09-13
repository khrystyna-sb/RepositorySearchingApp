//
//  SearchRepositoryViewModel.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 06.09.2022.
//

import Foundation
import Combine

final class SearchRepositoryViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var githubRepositoryResults: GithubRepositoryResults?
    
    private let networkService = NetworkService()
    private var anyCancellable = Set<AnyCancellable>()

    init(searchText: String) {
        self.searchText = searchText
        getRepositories(searchText: searchText)
    }

    func getRepositories(searchText: String) {
        
        guard  let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)&per_page=30&page=1") else { return }
        
        networkService.getRepositories(url: url) { (result: Result<GithubRepositoryResults, Error>) in
              switch result {
              case .success(let result):
                  self.githubRepositoryResults = result
                  print(result.items)
              case .failure(let error):
                print("error = \(error)")
              }
            }
    }
}
