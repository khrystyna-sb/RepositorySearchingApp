//
//  ViewController.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import UIKit
import WebKit

fileprivate struct Constants {
    static let githubLogInButtonHeight: CGFloat = 50
    static let githubLogInButtonWigth: CGFloat = 200
}

class LoginViewController: UIViewController {
    
    private let githubLogInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Log In", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(githubButtonClicked(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGithubButtonLayout()
    }
    
    func setupGithubButtonLayout() {
        view.addSubview(githubLogInButton)
        
        NSLayoutConstraint.activate([
            githubLogInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            githubLogInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            githubLogInButton.heightAnchor.constraint(equalToConstant: Constants.githubLogInButtonHeight),
            githubLogInButton.widthAnchor.constraint(equalToConstant: Constants.githubLogInButtonWigth)
        ])
    }
    
    @objc func githubButtonClicked(sender: UIButton) {
        let githubViewController = GitHubViewController()
        self.navigationController?.pushViewController(githubViewController, animated: true)
    }
}


