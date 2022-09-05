//
//  TokenFatcher.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import Foundation

class TokenFetcher {
    
    var token: String?
    
    func RequestForCallbackURL(request: URLRequest) -> String? {
        var finalCode: String? = nil
        let requestURLString = (request.url?.absoluteString)
        if let requestURLString = requestURLString {
            if requestURLString.contains(GithubConstants.REDIRECT_URI) {
                if requestURLString.contains("code=") {
                    if let range = requestURLString.range(of: "=") {
                        let githubCode = requestURLString[range.upperBound...]
                        if let range = githubCode.range(of: "&state=") {
                            let githubCodeFinal = githubCode[..<range.lowerBound]
                            finalCode = String(githubCodeFinal)
                        }
                    }
                }
            }
        }
        return finalCode
    }
    
    func githubRequestForAccessToken(authCode: String) {
        let grantType = "authorization_code"
  
        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + GithubConstants.CLIENT_ID + "&client_secret=" + GithubConstants.CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        guard let url = URL(string: GithubConstants.TOKENURL) else {return}
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, _) -> Void in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if statusCode == 200, let data = data {
                let results = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable: Any]
                if let accessToken = results?["access_token"] as? String {
                    self.token = accessToken
                }
            }
        }
        task.resume()
    }
}
