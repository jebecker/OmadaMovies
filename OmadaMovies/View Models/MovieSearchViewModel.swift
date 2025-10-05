//
//  MovieSearchViewModel.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import Foundation
import SwiftUI

/// Describes the interface for a movie search view model.
///
/// Implementations manage a debounced search query, expose a view state for rendering,
/// and provide an async `search()` function to trigger network requests.
protocol MovieSearchViewModeling {
    /// The raw search text bound to the UI. Updates are debounced before triggering a search.
    var searchQuery: String { get set }
    
    /// The debounced query value used when performing the actual search.
    var debouncedSearchQuery: String { get }
    
    /// The current state of the search UI (loading, loaded, empty, or error).
    var viewState: MovieSearchViewState { get }
    
    /// Triggers a search using the current `debouncedSearchQuery`, updating `viewState` accordingly.
    func search() async
}

/// Default implementation of `MovieSearchViewModeling`.
///
/// Handles debouncing of the user's input and manages a simple state machine to drive the UI.
@Observable
class MovieSearchViewModel: MovieSearchViewModeling {
    /// Default message shown when there are no results.
    private static let emptyStateMessage = "No results"
    
    /// The current view state driving UI rendering.
    var viewState: MovieSearchViewState
    
    /// The raw text from the search field. Changes are debounced before being applied to `debouncedSearchQuery`.
    var searchQuery: String = "" {
        didSet {
            // Cancel and replace any pending debounce work with the latest query change.
            debounceTask = Task { @MainActor in
                // If the user is typing (non-empty), wait 300ms to avoid firing on every keystroke.
                if !searchQuery.isEmpty {
                    try? await Task.sleep(nanoseconds: 300_000_000)
                }
                // Publish the debounced value to trigger downstream search.
                debouncedSearchQuery = searchQuery
            }
        }
    }
    
    /// The debounced query used for network requests.
    var debouncedSearchQuery: String = ""
    
    /// Abstraction over the network layer used to fetch movies.
    private var moviesSearchClient: MoviesNetworkAPIFetcher
    /// Tracks the current debounce task so a new change can supersede pending work.
    private var debounceTask: Task<Void, Never>?
    
    /// Creates a new view model.
    ///
    /// - Parameters:
    ///   - viewState: Initial state for the view. Defaults to an empty state with a default message.
    ///   - moviesSearchClient: Dependency used to fetch movies. Defaults to `MoviesSearchClient()`.
    init(
        viewState: MovieSearchViewState = .empty(MovieSearchViewModel.emptyStateMessage),
        moviesSearchClient: MoviesNetworkAPIFetcher = MoviesSearchClient()
    ) {
        self.viewState = viewState
        self.moviesSearchClient = moviesSearchClient
    }
    
    /// Evaluates the current `viewState` and `debouncedSearchQuery` to decide whether to perform a search
    /// and what state transitions to apply.
    func search() async {
        // State machine controlling when to search and what to show.
        switch viewState {
        // Already loading; continue the in-flight search with the latest debounced query.
        case .loading:
            await performSearch(query: debouncedSearchQuery)
        // Results are shown; if query is cleared, show empty. Otherwise, refresh with the new query.
        case .loaded(_):
            // If the user cleared the query, reset to empty state instead of searching.
            if debouncedSearchQuery.isEmpty {
                viewState = .empty(Self.emptyStateMessage)
                break
            }
            // Transition to loading before performing the search.
            viewState = .loading
            await performSearch(query: debouncedSearchQuery)
        // No results yet; only search if the query has content.
        case .empty(_):
            // Nothing to search when the query is empty.
            if debouncedSearchQuery.isEmpty {
                break
            }
            // Transition to loading before performing the search.
            viewState = .loading
            await performSearch(query: debouncedSearchQuery)
        // An error occurred previously; attempt the search again.
        case .error(_):
            viewState = .loading
            await performSearch(query: debouncedSearchQuery)
        }
    }
    
    /// Performs the network request using the provided query and updates `viewState` with results.
    ///
    /// - Parameter query: The debounced query string.
    private func performSearch(query: String) async {
        // Fetch movies from the network client.
        do {
            let movies = try await moviesSearchClient.searchMovies(query: query, page: nil)
            // If there are no results, present the empty state.
            guard !movies.isEmpty else {
                viewState = .empty(Self.emptyStateMessage)
                return
            }
            
            // Update to the loaded state with fetched results.
            viewState = .loaded(movies)
        } catch {
            // Log the error for debugging purposes.
            print(error.localizedDescription)
            viewState = .error(error.localizedDescription)
        }
    }
}
