//
//  MovieDetailsVC.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    let movieDetailVM : MovieDetailsVM
    
    // UI Components
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let titleLbl = UILabel()
    let ratingLbl = UILabel()
    let titleHStack = UIStackView()
    
    let overviewLbl = UILabel()
    let favouriteBtn = UIButton(type: .system)
    let trailerBtn = UIButton(type: .system)
    let runtimeLbl = UILabel()
    let genereLbl = UILabel()
    let castLbl = UILabel()
    
    init(movie: Movie) {
        self.movieDetailVM = MovieDetailsVM(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = movieDetailVM.movie.title
        
        setupUI()
        config()
        Task { @MainActor in
            guard let movDetails = try? await movieDetailVM.fetchDetails() else {
                return
            }
            runtimeLbl.text = "Duration: \(movDetails.runtime ?? 0) mins"
            genereLbl.text = "Genre: \(movDetails.genres.map{ $0.name }.joined(separator: " • "))"
        
            if let cast = movDetails.cast?.cast, !cast.isEmpty {
                castLbl.text = cast.map {$0.name}.joined(separator: " • ")
            } else {
                castLbl.text = "Cast: Not Available"
            }
        }
    }
}
