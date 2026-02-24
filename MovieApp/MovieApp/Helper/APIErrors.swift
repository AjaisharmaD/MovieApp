//
//  APIErrors.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

enum APIErrors: Error {
    case noInternet
    case timeout
    case invalidURL
    case invalidResponse
    case decodingFailed
    case requestFailed
    case movieNotFound
    case serverError(statusCode: Int)
}
