//
//  GitHubViewController.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import Foundation
import UIKit
import WebKit


class GitHubViewController: UIViewController {
    
    let tokenFetcher = TokenFetcher()
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebViewLayout()
        webViewSettings()
    }
    
    func webViewSettings() {
        webView.navigationDelegate = self
        
        let authURLFull = "https://github.com/login/oauth/authorize?client_id=" + GithubConstants.CLIENT_ID + "&scope=" + GithubConstants.SCOPE + "&redirect_uri=" + GithubConstants.REDIRECT_URI + "&state=" + UUID().uuidString
        
        let urlRequest = URLRequest(url: URL(string: authURLFull)!)
        webView.load(urlRequest)
    }
    
    func setupWebViewLayout() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension GitHubViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = tokenFetcher.RequestForCallbackURL(request: navigationAction.request) {
            self.dismiss(animated: true, completion: nil)
            tokenFetcher.githubRequestForAccessToken(authCode: code)
            let searchTableViewController = SearchRepositoryViewController()
            self.navigationController?.pushViewController(searchTableViewController, animated: true)
        }
        decisionHandler(.allow)
    }
}
