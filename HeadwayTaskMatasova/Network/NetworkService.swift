//
//  NetworkService.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 05.09.2022.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    
    func loadRepositories(request: URLRequest) -> AnyPublisher<GithubRepositoryResults, Error>
}

class NetworkService: NetworkServiceProtocol {
    
    var anyCancelable = Set<AnyCancellable>()
            
    func request(url: URL) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
            request.httpMethod = "GET"
     
            let headers = [
                "Accept": "application/json"
            ]
        
            request.allHTTPHeaderFields = headers
        
           return request
    }
    
    func loadRepositories(request: URLRequest) -> AnyPublisher<GithubRepositoryResults, Error> {
        
        return Future {[weak self] promise in
            guard let self = self else {return}
        URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse)}
                return result.data
            }
            .decode(type: GithubRepositoryResults.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { repositories in
                promise(.success(repositories))
            }
            .store(in: &self.anyCancelable)
        }
        .eraseToAnyPublisher()
    }
}
