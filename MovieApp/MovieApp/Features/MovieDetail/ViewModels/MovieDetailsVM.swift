//
//  MovieDetailsVM.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

final class MovieDetailsVM {
    private(set) var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var isFavourite: Bool {
        FavouritesManager.shared.isFavourite(movie.id)
    }
    
    func toggleFavourite() {
        FavouritesManager.shared.toggle(movie.id)
    }
    
    //MARK: Fetching movie trailer
    func fetchTrailer() async throws -> Video? {
        let res: VideoResponse = try await APIClient.shared.fetch(.videos(id: movie.id))
        
        return res.results.first {
            $0.site == "YouTube" && $0.type == "Trailer"
        }
    }
    
    //MARK: Fetching Genre, Runtime, Cast Details
    func fetchDetails() async throws -> MovieDetailResponse {
        let movieDetailRes: MovieDetailResponse = try await APIClient.shared.fetch(.details(id: movie.id))
        return movieDetailRes
    }
}
