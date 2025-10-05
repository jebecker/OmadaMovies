//
//  MovieSearchView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

/// A search screen that lets users find movies and browse results.
/// The UI reacts to `viewModel.viewState` and shows loading, results, empty, or error states.
struct MovieSearchView: View {
    /// The view model driving search and state transitions.
    @State private var viewModel: MovieSearchViewModeling = MovieSearchViewModel()
    
    var body: some View {
        NavigationStack {
            // Group keeps the switch readable and allows common modifiers (e.g., navigationTitle).
            Group {
                switch viewModel.viewState {
                // Show a spinner while fetching results.
                case .loading:
                    ProgressView("Loading...")
                // Display the list of matching movies.
                case .loaded(let movies):
                    MovieListView(movies: movies)
                // Inform the user when no results are found or before searching.
                case .empty(let message):
                    MessageView(message: message, systemImage: "popcorn")
                // Present an error message when the search fails.
                case .error(let error):
                    MessageView(title: "Oops!", message: error, systemImage: "exclamationmark.triangle")
                }
            }
            // Title of the screen shown in the navigation bar.
            .navigationTitle("Movie Search")
        }
        // Integrate the system search field; binds text to the view model.
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer,
            prompt: "Search for a movie"
        )
        // Trigger a search when the debounced query changes to limit network calls.
        .onChange(of: viewModel.debouncedSearchQuery) {
            Task {
                await viewModel.search()
            }
        }
    }
}
