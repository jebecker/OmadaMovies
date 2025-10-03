//
//  SearchMovieRequest.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

struct SearchMovieRequest: NetworkRequest {
    // In a real production level application, we would not expose this private API key like this. We would need to fetch this from a saved storage somewhere (backend ideally)
    static let apiKey = "b11fc621b3f7f739cb79b50319915f1d"
    
    private let searchQuery: String
    private let page: Int?
    private let includeAdult: Bool
    
    init(
        searchQuery: String,
        page: Int?,
        includeAdult: Bool = false
    ) {
        self.searchQuery  = searchQuery
        self.page = page
        self.includeAdult = includeAdult
    }
    
    
    var url: URL {
        URL(string: "https://api.themoviedb.org/\(path)")!
    }
    
    var path: String {
        "3/search/movie"
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var queryItems: [URLQueryItem]? {
        var items =
        [
            URLQueryItem(name: "api_key", value: Self.apiKey),
            URLQueryItem(name: "query", value: searchQuery),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "include_adult", value: includeAdult.description)
        ]
        
        if let page {
            items.append(URLQueryItem(name: "page", value: String(page)))
        }
        return items
    }
    
    var headers: [String : String]? {
        ["accept": "application/json"]
    }
    
    var body: [String : Any]? { nil }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        
        if let queryItems {
            request.url?.append(queryItems: queryItems)
            
        }
        
        if let body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
}
