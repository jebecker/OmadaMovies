//
//  MovieSearchViewModel.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import Foundation
import SwiftUI

protocol MovieSearchViewModeling {
    var searchQuery: String { get set }
    var debouncedSearchQuery: String { get }
    var viewState: MovieSearchViewState { get }
    
    func search() async
}

@Observable
class MovieSearchViewModel: MovieSearchViewModeling {
    private static let emptyStateMessage = "No results"
    
    var viewState: MovieSearchViewState
    
    var searchQuery: String = "" {
        didSet {
            debounceTask = Task { @MainActor in
                if !searchQuery.isEmpty {
                    try? await Task.sleep(nanoseconds: 300_000_000)
                }
                
                debouncedSearchQuery = searchQuery
            }
        }
    }
    
    var debouncedSearchQuery: String = ""
    
    private var moviesSearchClient: MoviesNetworkAPIFetcher
    private var debounceTask: Task<Void, Never>?
    
    init(
        viewState: MovieSearchViewState = .empty(MovieSearchViewModel.emptyStateMessage),
        moviesSearchClient: MoviesNetworkAPIFetcher = MoviesSearchClient()
    ) {
        self.viewState = viewState
        self.moviesSearchClient = moviesSearchClient
    }
    
    func search() async {
        switch viewState {
        case .loading:
            await performSearch(query: debouncedSearchQuery)
        case .loaded(_):
            if debouncedSearchQuery.isEmpty {
                viewState = .empty(Self.emptyStateMessage)
                break
            }
            viewState = .loading
            await performSearch(query: debouncedSearchQuery)
        case .empty(_):
            if debouncedSearchQuery.isEmpty {
                break
            }
            viewState = .loading
            await performSearch(query: debouncedSearchQuery)
        case .error(_):
            viewState = .loading
            await performSearch(query: debouncedSearchQuery)
        }
    }
    
    private func performSearch(query: String) async {
        do {
            let movies = try await moviesSearchClient.searchMovies(query: query, page: nil)
            guard !movies.isEmpty else {
                viewState = .empty(Self.emptyStateMessage)
                return
            }
            
            viewState = .loaded(movies)
        } catch {
            print(error.localizedDescription)
            viewState = .error(error.localizedDescription)
        }
    }
}
