//
//  NetworkClientError.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

// MARK: - Network Errors

/*
 A common error type used by the networking layer to surface failures
 in a user-friendly way. Conforms to `Error` and `LocalizedError` so
 descriptions can be shown directly in UI or logs.
 */
/// Errors that can occur when performing network requests.
enum NetworkClientError: Error {
    /// A catch-all error that wraps an underlying error message.
    /// The associated value is a human-readable description.
    case genericError(String)
    /// Indicates a non-success HTTP status code returned by the server.
    /// The associated value is the HTTP status code.
    case httpError(Int)
    /// Indicates that decoding the response body into expected models failed.
    case decodingError
    
    /// A user-facing description of the error suitable for alerts and logs.
    /// Provided to satisfy `LocalizedError` conformance.
    var localizedDescription: String {
        switch self {
        case .httpError(let errorCode):
            "Response returned HTTP Status code: \(errorCode)"
        case .decodingError:
            "There was an error decoding the returned JSON. Check the response being returned"
        case .genericError(let error):
            "An error occurred when trying to fetch the data:\n\(error)"
        }
    }
}

