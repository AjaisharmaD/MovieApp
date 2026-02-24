//
//  MoviesCVCell.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import UIKit

class MoviesCVCell: UICollectionViewCell {
    static let id = "MovieCell"
    
    private let imageView = UIImageView()
    private let titleLbl = UILabel()
    let favIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI() {
        self.contentView.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        titleLbl.font = .boldSystemFont(ofSize: 20)
        titleLbl.numberOfLines = 2
        
        favIcon.tintColor = .systemRed

        let favIconView = UIView()
        favIconView.addSubview(favIcon)
        let titleHStack = UIStackView(arrangedSubviews: [titleLbl, favIconView])
        titleHStack.axis = .horizontal
        titleHStack.spacing = 10
        
        favIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [imageView, titleHStack])
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            //MARK: for fav icon
            favIcon.trailingAnchor.constraint(equalTo: favIconView.trailingAnchor, constant: -8),
            favIcon.centerYAnchor.constraint(equalTo: favIconView.centerYAnchor),
            favIcon.heightAnchor.constraint(equalToConstant: 25),
            favIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

extension MoviesCVCell {
    func configure(to movie: Movie) {
        self.titleLbl.text = movie.title
        let isFav = FavouritesManager.shared.isFavourite(movie.id)
        favIcon.image = UIImage(systemName: isFav ? "heart.fill" : "heart")
        loadImage(from: movie.posterURL)
    }
    
    private func loadImage(from url: URL?) {
        self.imageView.image = nil
        
        guard let url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
}
