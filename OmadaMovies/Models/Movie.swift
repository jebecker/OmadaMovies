//
//  Movie.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

struct Movie: Codable, Equatable, Identifiable {
    let id: Double
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
