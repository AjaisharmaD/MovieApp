//
//  MovieDetailsResponse.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

struct MovieDetailResponse: Decodable {
    let runtime: Int?
    let genres: [Genre]
    let cast: CreditResponse?
}

struct Genre: Decodable {
    let name: String
}

struct CreditResponse: Decodable {
    let cast:[Actor]
}

struct Actor: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
