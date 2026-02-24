//
//  MovieVC+SearchManager.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation
import UIKit

extension MoviesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            fetchMovies()
            return
        }
        Task {
            await movieVM.searchMovie(text)
            collectionView.reloadData()
        }
    }
    
    func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter Movie Name"
        searchController.searchResultsUpdater = self
    }
}
