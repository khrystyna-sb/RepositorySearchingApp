//
//  NetworkService.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 05.09.2022.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    
    func fetch(url: URL, completion: @escaping (Result<GithubRepositoryResults, Error>) -> Void )
}

class NetworkService: NetworkServiceProtocol {
    
    var anyCancelable = Set<AnyCancellable>()
    
    func fetch(url: URL, completion: @escaping (Result<GithubRepositoryResults, Error>) -> Void ) {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
          .map { $0.data }
          .decode(type: GithubRepositoryResults.self, decoder: decoder)
          .receive(on: DispatchQueue.main)
          .sink { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
              completion(.failure(error))
            case .finished:
              return
            }
          } receiveValue: { (resultArr) in
            completion(.success(resultArr))
          }
          .store(in: &anyCancelable)
      }
    
}



