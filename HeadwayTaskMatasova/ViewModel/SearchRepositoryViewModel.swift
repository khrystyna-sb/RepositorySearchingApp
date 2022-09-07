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
//    private var pagination: (currentPage: Int,
//                             results: GithubRepositoryResults?) = (0, nil)

    init(searchText: String) {
        self.searchText = searchText
        getRepositories(searchText: searchText)
    }

    func getRepositories(searchText: String) {
        
        guard  let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)&per_page=30&page=1") else { return }
        
        let request = networkService.request(url: url)
        networkService.loadRepositories(request: request as URLRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] results in
                guard let self = self else {return}
                self.githubRepositoryResults = results
            }
            .store(in: &anyCancellable)
    }
}
