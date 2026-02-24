//
//  MoviesVM.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

final class MoviesVM {
    private(set) var movies: [Movie] = []
    
    func fetchPopularMovies() async throws {
        let res: MovieListResponse = try await APIClient.shared.fetch(.popular(page: 1))
        movies = res.results
    }
    
    var count: Int {
        movies.count
    }
    
    func movie(at index: Int) -> Movie {
        movies[index]
    }
    
    //MARK: Searching
    func searchMovie(_ query: String) async {
        do {
            let res: MovieListResponse = try await APIClient.shared.fetch(.search(query: query))
            
            movies = res.results
        } catch {
            print("Error:", error)
        }
    }
}
