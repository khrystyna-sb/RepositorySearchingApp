//
//  NetworkService.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 05.09.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func request(url: URL) -> NSMutableURLRequest
    func dataTask(request: URLRequest, repositoryData: @escaping (GithubRepositoryResults?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func request(url: URL) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
            request.httpMethod = "GET"
     
            let headers = [
                "Accept": "application/json"
            ]
        
            request.allHTTPHeaderFields = headers
        
           return request
    }
    
    func dataTask(request: URLRequest, repositoryData: @escaping (GithubRepositoryResults?) -> Void) {
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        guard error == nil else { return }
        
                            guard let data = data else {return}
                            do {
                                let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                let json = try decoder.decode(GithubRepositoryResults.self, from: data)
                                repositoryData(json)
                            } catch let error {
                                print("Failed to decode JSON: \(error)")
                                repositoryData(nil)
                            }
                        }
                }).resume()
    }
}
