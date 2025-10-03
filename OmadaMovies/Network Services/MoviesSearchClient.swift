//
//  MoviesSearchClient.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

protocol MoviesNetworkAPIFetcher {
    
    func searchMovies(query: String, page: Int?) async throws -> [Movie]
}

struct MoviesSearchClient: MoviesNetworkAPIFetcher {
    
    func searchMovies(query: String, page: Int? = nil) async throws -> [Movie] {
        let searchMovieRequest = SearchMovieRequest(searchQuery: query, page: page)
        
        let (data, response) = try await URLSession.shared.data(for: searchMovieRequest.urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkClientError.genericError("Could not convert response: \(response)\n to HTTPURLResponse")
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkClientError.httpError(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let movieSearchResponse = try decoder.decode(MovieSearchResponse.self, from: data)
            return movieSearchResponse.results
        } catch {
            throw NetworkClientError.decodingError
        }
    }
}
