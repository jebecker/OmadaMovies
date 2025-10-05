//
//  SearchMovieRequest.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

/// A concrete `NetworkRequest` that builds a search request against The Movie Database (TMDB) API.
///
/// Provides the endpoint path, query parameters, headers, and a fully constructed `URLRequest`.
struct SearchMovieRequest: NetworkRequest {
    /// The TMDB API key used to authorize requests.
    /// Note: Do not ship production apps with hard-coded secrets; use secure storage or a backend proxy.
    private static let apiKey = "b11fc621b3f7f739cb79b50319915f1d"
    
    /// The user-provided search text used to query TMDB for matching movies.
    private let searchQuery: String
    /// Optional page number for paginated results (1-based). If `nil`, the API default is used.
    private let page: Int?
    /// Whether to include adult results in the search.
    private let includeAdult: Bool
    
    /// Creates a new search request.
    ///
    /// - Parameters:
    ///   - searchQuery: The text to search for.
    ///   - page: Optional page index for paginated results.
    ///   - includeAdult: Whether to include adult results. Defaults to `false`.
    init(
        searchQuery: String,
        page: Int?,
        includeAdult: Bool = false
    ) {
        self.searchQuery  = searchQuery
        self.page = page
        self.includeAdult = includeAdult
    }
    
    /// Full endpoint URL composed from base host and `path`.
    var url: URL {
        URL(string: "https://api.themoviedb.org/\(path)")!
    }
    
    /// Endpoint path for the TMDB movie search API.
    var path: String {
        "3/search/movie"
    }
    
    /// HTTP method used for the request.
    var httpMethod: String {
        "GET"
    }
    
    /// Query parameters for the search request, including API key, search term, language, adult filter, and optional page.
    var queryItems: [URLQueryItem]? {
        // Base query parameters required by TMDB search endpoint.
        var items =
        [
            URLQueryItem(name: "api_key", value: Self.apiKey),
            URLQueryItem(name: "query", value: searchQuery),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "include_adult", value: includeAdult.description)
        ]
        
        // Append page parameter if provided.
        if let page {
            items.append(URLQueryItem(name: "page", value: String(page)))
        }
        return items
    }
    
    /// HTTP headers to include with the request.
    var headers: [String : String]? {
        ["accept": "application/json"]
    }
    
    /// Optional HTTP body payload. Not used for this GET request.
    var body: [String : Any]? { nil }
    
    /// Fully constructed `URLRequest` including method, headers, query parameters, and optional body.
    var urlRequest: URLRequest {
        // Build the URLRequest and apply method and headers.
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        
        // Attach query parameters to the URL.
        if let queryItems {
            request.url?.append(queryItems: queryItems)
            
        }
        
        // Encode body as JSON if provided.
        if let body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
}

