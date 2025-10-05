//
//  MoviesSearchClient.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

/// A lightweight abstraction for fetching movies from a network API.
///
/// Conforming types perform the actual network request and decoding.
protocol MoviesNetworkAPIFetcher {
    
    /// Searches for movies matching a query string.
    ///
    /// - Parameters:
    ///   - query: The text to search for.
    ///   - page: Optional page index for paginated results (1-based). Pass `nil` to use the API default.
    /// - Returns: A list of `Movie` results for the requested page.
    /// - Throws: An error if the request fails or decoding fails.
    func searchMovies(query: String, page: Int?) async throws -> [Movie]
}

/// Default implementation of `MoviesNetworkAPIFetcher` that calls the remote movie API using `URLSession`.
///
/// Decodes responses with `JSONDecoder` using `.convertFromSnakeCase` to map API keys to Swift property names.
struct MoviesSearchClient: MoviesNetworkAPIFetcher {
    
    /// Searches the movie API for titles matching the query.
    ///
    /// - Parameters:
    ///   - query: The text to search for.
    ///   - page: Optional page index for paginated results (1-based). Defaults to `nil`.
    /// - Returns: An array of `Movie` objects on success.
    /// - Throws: `NetworkClientError` when the request fails, returns a non-2xx status, or decoding fails.
    func searchMovies(query: String, page: Int? = nil) async throws -> [Movie] {
        // Build the request for the search endpoint.
        let searchMovieRequest = SearchMovieRequest(searchQuery: query, page: page)
        
        // Execute the request using the async/await `URLSession` API.
        let (data, response) = try await URLSession.shared.data(for: searchMovieRequest.urlRequest)
        
        // Ensure we received a valid HTTP response.
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkClientError.genericError("Could not convert response: \(response)\n to HTTPURLResponse")
        }
        
        // Validate that the status code indicates success (2xx).
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkClientError.httpError(httpResponse.statusCode)
        }
        
        // Configure decoder to map snake_case keys to camelCase properties.
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Decode the paginated response and return the movies list.
        do {
            let movieSearchResponse = try decoder.decode(MovieSearchResponse.self, from: data)
            return movieSearchResponse.results
        } catch {
            // Bubble up a typed error if the payload cannot be decoded.
            throw NetworkClientError.decodingError
        }
    }
}

