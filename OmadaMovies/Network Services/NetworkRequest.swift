//
//  NetworkRequest.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

protocol NetworkRequest {
    var url: URL { get }
    var httpMethod: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
    var path: String { get }
    var urlRequest: URLRequest { get }
}
