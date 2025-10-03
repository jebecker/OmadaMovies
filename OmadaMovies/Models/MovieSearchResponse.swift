//
//  MovieSearchResponse.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

struct MovieSearchResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
