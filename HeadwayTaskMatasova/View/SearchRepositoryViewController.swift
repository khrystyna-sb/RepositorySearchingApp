//
//  SearchRepositoryViewController.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import UIKit
import Combine

class SearchRepositoryViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private(set) var viewModel: SearchRepositoryViewModel?
    private var anyCancellable = Set<AnyCancellable>()
        
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
        viewModel?.githubRepositoryResults?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let repositoryName = viewModel?.githubRepositoryResults?.items[indexPath.row]
        cell.textLabel?.text = repositoryName?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController()
        repositoryDetailsViewController.githubRepositoryResult = viewModel?.githubRepositoryResults?.items[indexPath.row]
        navigationController?.pushViewController(repositoryDetailsViewController, animated: true)
    }
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel = SearchRepositoryViewModel(searchText: searchText)
        self.tableView.reloadData()
        }
}
