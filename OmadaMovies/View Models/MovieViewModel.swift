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
    let formattedViewerRating: String
    
    var overview: String {
        movie.overview
    }
    
    var viewerRating: Double {
        movie.voteAverage
    }
    
    var title: String {
        movie.title
    }

    private let movie: Movie
    
    // Move all computational heavy operations to be only done once on init to help best align with SwiftUI's view cycle creation
    init(movie: Movie) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.movie = movie
        self.releaseYear = Self.createReleaseYear(formatter: formatter, releaseDate: movie.releaseDate)
        self.releaseDate = Self.createReleaseDate(formatter: formatter, releaseDate: movie.releaseDate)
        self.posterURL = Self.createPosterURL(posterPath: movie.posterPath)
        self.formattedViewerRating = "\(String(format: "%.1f", movie.voteAverage))/10"
    }
            
    private static func createReleaseYear(formatter: DateFormatter, releaseDate: String) -> String {
        let date = formatter.date(from: releaseDate) ?? Date()
        let year = Calendar.current.component(.year, from: date)
        return "\(year)"
    }
    
    private static func createReleaseDate(formatter: DateFormatter, releaseDate: String) -> String {
        let date = formatter.date(from: releaseDate) ?? Date()
        return date.formatted(date: .long, time: .omitted)
    }
    
    private static func createPosterURL(posterPath: String?) -> URL? {
        guard let posterPath else { return nil }
        // request a 300 pixel wide image instead of receiving the full sized image from the server ('w300')
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")
    }
}
