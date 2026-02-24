//
//  MovieDetailsVC+Setup.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import UIKit

extension MovieDetailsVC {
    func setupUI() {
        let titleVStack = UIStackView(arrangedSubviews: [titleLbl, ratingLbl])
        titleVStack.axis = .vertical
        titleVStack.spacing = 12
        
        let favBtnView = UIView()
        favBtnView.addSubview(favouriteBtn)
        
        favouriteBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let titleHStack = UIStackView(arrangedSubviews: [titleVStack, favBtnView])
        titleHStack.axis = .horizontal
        titleHStack.spacing = 20
        
        let contentView = UIStackView(arrangedSubviews: [imageView, titleHStack, overviewLbl, genereLbl, runtimeLbl, castLbl, trailerBtn])
        contentView.axis = .vertical
        contentView.spacing = 12
        
        titleLbl.font = .boldSystemFont(ofSize: 22)
        
        overviewLbl.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        trailerBtn.setTitle("▶️ Watch Trailer", for: .normal)
        trailerBtn.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
        
        favouriteBtn.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
        favouriteBtn.tintColor = .systemRed
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            favouriteBtn.trailingAnchor.constraint(equalTo: favBtnView.trailingAnchor, constant: -5),
            favouriteBtn.centerYAnchor.constraint(equalTo: favBtnView.centerYAnchor),
            favouriteBtn.heightAnchor.constraint(equalToConstant: 40),
            favouriteBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func config() {
        let movie = movieDetailVM.movie
        
        titleLbl.text = movie.title
        let voteAverage = movie.voteAverage
        let rating = floor(voteAverage * 10) / 10
        ratingLbl.text = "⭐️ \(rating)"
        overviewLbl.text = movie.overview
        
        if let url = movie.posterURL {
            loadPosterImage(from: url)
        }
        
        updateFavBtn()
    }
    
    func loadPosterImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
    
    @objc func toggleFavourite(){
        movieDetailVM.toggleFavourite()
        updateFavBtn()
    }
    
    @objc func playTrailer() {
        Task {
            guard let video = try? await movieDetailVM.fetchTrailer() else {
                return
            }
            
            await MainActor.run {
                let trailerVC = TrailerVC(key: video.key)
                present(trailerVC, animated: true)
            }
            
        }
    }
    
    private func updateFavBtn() {
        let image = UIImage(systemName: movieDetailVM.isFavourite ? "heart.fill" : "heart")
        favouriteBtn.setImage(image, for: .normal)
    }
}
