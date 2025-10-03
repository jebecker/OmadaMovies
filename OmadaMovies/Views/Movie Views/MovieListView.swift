//
//  MovieListView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

struct MovieListView: View {
    let movies: [Movie]
    
    var body: some View {
        List(movies) { movie in
            MovieView(viewModel: MovieViewModel(movie: movie))
        }
        .listStyle(.plain)
    }
}


struct MovieView: View {
    let viewModel: MovieViewModeling
    
    var body: some View {
        NavigationLink {
            Text("DETAILS")
        } label: {
            HStack(alignment: .top) {
                PosterImageView(posterURL: viewModel.posterURL)
                
                MovieReleaseDetailsView(
                    title: viewModel.title,
                    releaseDate: viewModel.releaseYear
                )
            }
        }
    }
}

struct PosterImageView: View {
    let posterURL: URL?
    
    var body: some View {
        // Scroll performance is acceptable because we are requesting a 300 pixel wide image from the server which roughly matches the desired frame below
        // In order to entirely eliminate scroll performance issues, an image downloading, resizing and caching system would need to be created to do all computation on a background thread
        // Then the finished image would be sent back to the ImageView completely configured with no scaling and rendering on the main thread
        AsyncImage(url: posterURL) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 150)
        } placeholder: {
            Image(systemName: "movieclapper")
                .frame(width: 100, height: 150)
        }
    }
}

protocol MovieViewModeling {
    var releaseYear: String { get }
    var releaseDate: String { get }
    var posterURL: URL? { get }
    var overview: String { get }
    var viewerRating: Double { get }
    var title: String { get }
}

struct MovieViewModel: MovieViewModeling {
    let releaseYear: String
    let releaseDate: String
    let posterURL: URL?
    let overview: String
    let viewerRating: Double
    let title: String
    
    // Move all computation to be only done once on init to help best align with SwiftUI's view cycle creation
    init(movie: Movie) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        releaseYear = Self.createReleaseYear(formatter: formatter, releaseDate: movie.releaseDate)
        releaseDate = Self.createReleaseDate(formatter: formatter, releaseDate: movie.releaseDate)
        posterURL = Self.createPosterURL(posterPath: movie.posterPath)
        overview = movie.overview
        viewerRating = movie.voteAverage.rounded()
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
