//
//  RepositoryDetailsViewController.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 05.09.2022.
//

import UIKit

struct StackViewConstants {
    static let nameLabelPrefix = "Name: "
    static let stargazersCountLabelPrifix = "Stargazers: "
    static let languageLabelPrefix = "Language: "
    static let descriptionLabelPrefix = "Description: "

}

class RepositoryDetailsViewController: UIViewController {
    
    var githubRepositoryResult: GithubRepositoryResult?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackViewLayout()
        addSubbviewsToStack()
    }
    
    private func setupStackViewLayout() {
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSubbviewsToStack() {
        guard let githubRepositoryResult = githubRepositoryResult else { return }
        let nameLabel = UILabel()
        nameLabel.text = StackViewConstants.nameLabelPrefix + githubRepositoryResult.name
        mainStackView.addArrangedSubview(nameLabel)
        let stargazersCountLabel = UILabel()
        stargazersCountLabel.text = StackViewConstants.stargazersCountLabelPrifix + "\(githubRepositoryResult.stargazersCount)"
        mainStackView.addArrangedSubview(stargazersCountLabel)
        if let language = githubRepositoryResult.language {
            let languageLabel = UILabel()
            languageLabel.text = StackViewConstants.languageLabelPrefix + language
            mainStackView.addArrangedSubview(languageLabel)
        }
        if let description = githubRepositoryResult.description {
            let descriptionLabel = UILabel()
            descriptionLabel.text = StackViewConstants.descriptionLabelPrefix + description
            mainStackView.addArrangedSubview(descriptionLabel)
        }
    }
}
