//
//  SearchViewController.swift
//  DispatchWorkItem-Example
//
//  Created by Mac on 11/04/22.
//

import UIKit

class SearchViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var searchWork: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchWork?.cancel()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        findUser(for: searchText)
    }
    
    private func findUser(for string: String) {
        searchWork?.cancel()
        let work = DispatchWorkItem {
            print("Hello, \(string)!")
        }
        
        work.notify(queue: .main) {
            print("Search finished!")
        }
        searchWork = work
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: work)
    }
}

