//
//  Endpoints.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

enum Endpoints {
    case popular(page: Int)
    case details(id: Int)
    case videos(id: Int)
    case search(query: String)
    
    var url: URL? {
        switch self {
        case .popular(let page):
            return URL(string: "\(Constants.baseURL)/movie/popular?api_key=\(Constants.apiKey)&page=\(page)")
        case .details(let id):
            return URL(string: "\(Constants.baseURL)/movie/\(id)?api_key=\(Constants.apiKey)&append_to_response=credits")
        case .videos(let id):
            return URL(string: "\(Constants.baseURL)/movie/\(id)/videos?api_key=\(Constants.apiKey)")
        case .search(let query):
            let qry = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return URL(string: "\(Constants.baseURL)/search/movie?api_key=\(Constants.apiKey)&query=\(qry)")
        }
    }
}
