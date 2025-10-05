//
//  MovieListView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

/// Displays a list of movies using `MovieView` rows.
struct MovieListView: View {
    /// The collection of movies to display.
    let movies: [Movie]
    
    var body: some View {
        // List to render each movie as a row.
        List(movies) { movie in
            MovieView(viewModel: MovieViewModel(movie: movie))
        }
        // Remove separators and extra styling for a simple appearance.
        .listStyle(.plain)
    }
}
