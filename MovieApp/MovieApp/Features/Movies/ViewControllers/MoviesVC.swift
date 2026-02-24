//
//  MoviesVC.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import UIKit

class MoviesVC: UIViewController {
    let movieVM = MoviesVM()
    
    var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular Movies"
        
        view.backgroundColor = .systemBackground
        
        setupSearchBar()
        setupCollectioView()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}
