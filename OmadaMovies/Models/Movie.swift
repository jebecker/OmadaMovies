//
//  Movie.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import Foundation

/// A lightweight model representing a movie returned by the app's API (compatible with common TMDB-style fields).
///
/// Conforms to `Codable` for JSON parsing, `Equatable` for comparisons, and `Identifiable` for use in SwiftUI lists.
struct Movie: Codable, Equatable, Identifiable {
    /// Unique identifier for the movie.
    let id: Double
    /// Indicates whether the movie is intended for adult audiences.
    let adult: Bool
    /// Relative path to a backdrop image. Combine with your image base URL to form a full URL. Optional if unavailable.
    let backdropPath: String?
    /// List of numeric genre identifiers associated with the movie.
    let genreIds: [Int]
    /// ISO 639-1 language code of the movie's original production language (e.g., "en", "es").
    let originalLanguage: String
    /// Original title as released in the original language.
    let originalTitle: String
    /// Short synopsis or description of the movie.
    let overview: String
    /// Popularity score provided by the API; higher values indicate greater relative popularity.
    let popularity: Double
    /// Relative path to the poster image. Combine with your image base URL to form a full URL. Optional if unavailable.
    let posterPath: String?
    /// Release date in the format "YYYY-MM-DD". Consider parsing to `Date` when needed.
    let releaseDate: String
    /// Current or localized title suitable for display.
    let title: String
    /// Whether this result represents a video item (e.g., trailer) rather than a feature film.
    let video: Bool
    /// Average user rating on a 0.0–10.0 scale.
    let voteAverage: Double
    /// Number of user votes contributing to `voteAverage`.
    let voteCount: Int
}
