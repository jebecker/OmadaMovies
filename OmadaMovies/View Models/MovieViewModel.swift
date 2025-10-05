//
//  MovieViewModel.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import Foundation

/// Defines the data needed to display a movie in the UI.
///
/// Implementations expose both raw and formatted values suitable for presentation.
protocol MovieViewModeling {
    /// Four-digit year extracted from the full release date.
    var releaseYear: String { get }
    /// Localized, human-readable release date.
    var releaseDate: String { get }
    /// URL to a moderately sized poster image (w300), if available.
    var posterURL: URL? { get }
    /// Synopsis/description of the movie.
    var overview: String { get }
    /// Raw average viewer rating on a 0–10 scale.
    var viewerRating: Double { get }
    /// User-facing rating string (e.g., "7.8/10").
    var formattedViewerRating: String { get }
    /// Display title for the movie.
    var title: String { get }
}

/// View model that formats a `Movie` for presentation.
///
/// Performs one-time formatting in `init` to align with SwiftUI's view lifecycle and avoid repeated work.
struct MovieViewModel: MovieViewModeling {
    /// Four-digit year derived from the movie's release date.
    let releaseYear: String
    /// Localized long-form release date string.
    let releaseDate: String
    /// URL for a w300 poster image, if a poster path is available.
    let posterURL: URL?
    /// Pre-formatted viewer rating (e.g., "7.8/10").
    let formattedViewerRating: String
    
    /// Synopsis/description of the movie.
    var overview: String {
        movie.overview
    }
    
    /// Raw average viewer rating from the API.
    var viewerRating: Double {
        movie.voteAverage
    }
    
    /// Display title for the movie.
    var title: String {
        movie.title
    }

    /// Underlying `Movie` model used to derive presented values.
    private let movie: Movie
    
    /// Initializes the view model and derives formatted values from the provided `Movie`.
    ///
    /// - Parameter movie: The source movie from which to derive display values.
    init(movie: Movie) {
        // Date formatter used to parse API release date strings (YYYY-MM-DD).
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.movie = movie
        self.releaseYear = Self.createReleaseYear(formatter: formatter, releaseDate: movie.releaseDate)
        self.releaseDate = Self.createReleaseDate(formatter: formatter, releaseDate: movie.releaseDate)
        self.posterURL = Self.createPosterURL(posterPath: movie.posterPath)
        // Format the average rating to one decimal place for display.
        self.formattedViewerRating = "\(String(format: "%.1f", movie.voteAverage))/10"
    }
            
    /// Parses the release date string and returns the four-digit release year.
    ///
    /// - Parameters:
    ///   - formatter: Configured `DateFormatter` for parsing.
    ///   - releaseDate: The raw release date string (e.g., "2024-05-01").
    /// - Returns: The year as a string.
    private static func createReleaseYear(formatter: DateFormatter, releaseDate: String) -> String {
        let date = formatter.date(from: releaseDate) ?? Date()
        let year = Calendar.current.component(.year, from: date)
        return "\(year)"
    }
    
    /// Parses the release date string and returns a localized long-form date.
    ///
    /// - Parameters:
    ///   - formatter: Configured `DateFormatter` for parsing.
    ///   - releaseDate: The raw release date string.
    /// - Returns: A user-friendly, localized date string.
    private static func createReleaseDate(formatter: DateFormatter, releaseDate: String) -> String {
        let date = formatter.date(from: releaseDate) ?? Date()
        return date.formatted(date: .long, time: .omitted)
    }
    
    /// Builds a poster image URL for the TMDB CDN using the provided poster path.
    ///
    /// - Parameter posterPath: Optional relative path to the poster image returned by the API.
    /// - Returns: A `URL` to a w300 image, or `nil` if no path is available.
    private static func createPosterURL(posterPath: String?) -> URL? {
        guard let posterPath else { return nil }
        // request a 300 pixel wide image instead of receiving the full sized image from the server ('w300')
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")
    }
}
