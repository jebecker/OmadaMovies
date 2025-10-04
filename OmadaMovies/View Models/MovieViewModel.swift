//
//  MovieViewModel.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import Foundation

protocol MovieViewModeling {
    var releaseYear: String { get }
    var releaseDate: String { get }
    var posterURL: URL? { get }
    var overview: String { get }
    var viewerRating: Double { get }
    var formattedViewerRating: String { get }
    var title: String { get }
}

struct MovieViewModel: MovieViewModeling {
    let releaseYear: String
    let releaseDate: String
    let posterURL: URL?
    let overview: String
    let viewerRating: Double
    let formattedViewerRating: String
    let title: String
    
    // Move all computation to be only done once on init to help best align with SwiftUI's view cycle creation
    init(movie: Movie) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        releaseYear = Self.createReleaseYear(formatter: formatter, releaseDate: movie.releaseDate)
        releaseDate = Self.createReleaseDate(formatter: formatter, releaseDate: movie.releaseDate)
        posterURL = Self.createPosterURL(posterPath: movie.posterPath)
        overview = movie.overview
        viewerRating = movie.voteAverage
        formattedViewerRating = "\(String(format: "%.1f", movie.voteAverage))/10"
        title = movie.title
    }
    
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    private static func createReleaseYear(formatter: DateFormatter, releaseDate: String) -> String {
        let date = formatter.date(from: releaseDate) ?? Date()
        let year = Calendar.current.component(.year, from: date)
        return "\(year)"
    }
    
    private static func createReleaseDate(formatter: DateFormatter, releaseDate: String) -> String {
        let date = formatter.date(from: releaseDate) ?? Date()
        return date.formatted(date: .long, time: .standard)
    }
    
    private static func createPosterURL(posterPath: String?) -> URL? {
        guard let posterPath else { return nil }
        // request a 300 pixel wide image instead of receiving the full sized image from the server ('w300')
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")
    }
}
