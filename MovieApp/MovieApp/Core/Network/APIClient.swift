//
//  APIClient.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    private init() {}

    func fetch<T: Decodable>(_ endpoint: Endpoints) async throws -> T {

        guard let url = endpoint.url else {
            throw APIErrors.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw APIErrors.invalidResponse
        }
        
        switch http.statusCode {
        case 200...209:
            break
        case 401:
            throw APIErrors.serverError(statusCode: 401)
        case 404:
            throw APIErrors.serverError(statusCode: 404)
        default:
            throw APIErrors.serverError(statusCode: http.statusCode)
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIErrors.decodingFailed
        }
    }
}
