//
//  Movie.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

struct MovieListResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

extension Movie {
    var posterURL: URL? {
        guard let path = posterPath else {
            return nil
        }
        
        return URL(string: Constants.imageBaseURL + path)
    }
}
