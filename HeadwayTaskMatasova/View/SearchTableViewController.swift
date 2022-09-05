//
//  SearchTableViewController.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var githubRepositoryResults: GithubRepositoryResults?
    let networkService = NetworkService()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        githubRepositoryResults?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let repositoryName = githubRepositoryResults?.items[indexPath.row]
        cell.textLabel?.text = repositoryName?.name
        return cell
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            guard  let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)&per_page=30&page=1") else { return }
            
            let request = networkService.request(url: url)
            networkService.dataTask(request: request as URLRequest, repositoryData: { (repositoryData) in
                guard let repositoryData = repositoryData else {return}
                self.githubRepositoryResults = repositoryData
                self.tableView.reloadData()
            })
        }
}
