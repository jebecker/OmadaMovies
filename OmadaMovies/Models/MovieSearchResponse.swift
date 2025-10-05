//
//  MovieSearchResponse.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

/// A paginated response returned from a movie search request.
///
/// Contains the current page of results, the list of `Movie` items, and pagination metadata.
struct MovieSearchResponse: Decodable {
    /// The index of the current results page (1-based).
    let page: Int
    /// The list of movies for the current page.
    let results: [Movie]
    /// The total number of pages available for this query.
    let totalPages: Int
    /// The total number of results matching the query across all pages.
    let totalResults: Int
}

