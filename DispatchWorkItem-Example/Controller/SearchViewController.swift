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
    
    let queue: DispatchQueue = .global()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        let work = DispatchWorkItem {
            print("Start work ->", Date())
            sleep(10)
            print("Finished work ->", Date())
        }

        let work2 = DispatchWorkItem {
            print("Start work 2 ->", Date())
            sleep(5)
            print("Finished work 2 ->", Date())
        }

        queue.asyncAfter(deadline: .now(), execute: work)
        queue.asyncAfter(deadline: .now(), execute: work2)
         work2.wait() // Wait until work has to be finished
         print("Finished") // Will print after work finished
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
            // Perform another task
        }
        searchWork = work
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: work)
    }
}

