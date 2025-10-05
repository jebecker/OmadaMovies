//
//  NetworkRequest.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

/// A protocol that describes the components required to build a network request.
///
/// Conforming types provide enough information to construct a `URLRequest`, including
/// base URL, endpoint path, HTTP method, query parameters, headers, and optional body.
protocol NetworkRequest {
    /// The base URL for the API host (e.g., https://api.example.com).
    var url: URL { get }
    /// The HTTP method to use for the request (e.g., "GET", "POST", "PUT", "DELETE").
    var httpMethod: String { get }
    /// Optional query parameters to append to the URL (e.g., pagination or search terms).
    var queryItems: [URLQueryItem]? { get }
    /// Optional HTTP header fields to include in the request (e.g., Authorization, Content-Type).
    var headers: [String: String]? { get }
    /// Optional request body payload. Implementations typically encode this as JSON in `urlRequest`.
    var body: [String: Any]? { get }
    /// Endpoint path to append to `url`. Should begin with "/".
    var path: String { get }
    /// A fully constructed `URLRequest` derived from the properties above.
    var urlRequest: URLRequest { get }
}
