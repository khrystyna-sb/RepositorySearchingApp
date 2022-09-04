//
//  TokenFatcher.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import Foundation

class TokenFetcher {
    
    func RequestForCallbackURL(request: URLRequest) {
        let requestURLString = (request.url?.absoluteString)! as String
        print("requestURLString = \(requestURLString)")
        if requestURLString.contains(GithubConstants.REDIRECT_URI) {
            if requestURLString.contains("code=") {
                if let range = requestURLString.range(of: "=") {
                    let githubCode = requestURLString[range.upperBound...]
                    if let range = githubCode.range(of: "&state=") {
                        let githubCodeFinal = githubCode[..<range.lowerBound]
                        githubRequestForAccessToken(authCode: String(githubCodeFinal))
                    }
                }
            }
        }
    }
    
    func githubRequestForAccessToken(authCode: String) {
        let grantType = "authorization_code"
        
        // Set the POST parameters.
        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + GithubConstants.CLIENT_ID + "&client_secret=" + GithubConstants.CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: URL(string: GithubConstants.TOKENURL)!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, _) -> Void in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                print("result for token = \(String(describing: results))")
                let accessToken = results?["access_token"] as! String
                 print("accessToken = \(accessToken)")
//                self.githubAccessToken = accessToken

//                DispatchQueue.main.async {
//                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "Details View Controller") as! DetailsViewController
//                    self.navigationController?.pushViewController(VC, animated: true)
//                }
            }
        }
        task.resume()
    }
}
