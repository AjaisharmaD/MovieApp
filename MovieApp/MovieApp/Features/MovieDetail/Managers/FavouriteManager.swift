//
//  FavouriteManager.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

final class FavouritesManager {
    static let shared = FavouritesManager()
    private let key = "favourite_movie_ids"
    
    private init() {}
    
    private var favIDs: Set<Int> {
        get { Set(UserDefaults.standard.array(forKey: key) as? [Int] ?? [])}
        set { UserDefaults.standard.set(Array(newValue), forKey: key)}
    }
    
    func isFavourite(_ id: Int) -> Bool {
        favIDs.contains(id)
    }
    
    func toggle(_ id: Int) {
        var set = favIDs
        
        if set.contains(id) {
            set.remove(id)
        } else {
            set.insert(id)
        }
        favIDs = set
    }
    
    // Returns the list of favourite movie IDs
    func allFavourites() -> Set<Int> {
        favIDs
    }
}
