//
//  VideoResponse.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
    let type: String
    let site: String
}
