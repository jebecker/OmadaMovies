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
