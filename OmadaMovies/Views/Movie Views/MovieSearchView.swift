//
//  MovieSearchView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

struct MovieSearchView: View {
    @State private var viewModel: MovieSearchViewModeling = MovieSearchViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.viewState {
                case .loading:
                    ProgressView("Loading...")
                case .loaded(let movies):
                    MovieListView(movies: movies)
                case .empty(let message):
                    MessageView(title: "", message: message, systemImage: "popcorn")
                case .error(let error):
                    MessageView(title: "Oops!", message: error, systemImage: "exclamationmark.triangle")
                }
            }
            .navigationTitle("Movie Search")
        }
        .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer)
        .onChange(of: viewModel.debouncedSearchQuery) {
            Task {
                await viewModel.search()
            }
        }
    }
}

