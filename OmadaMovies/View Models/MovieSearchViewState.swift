//
//  MovieSearchViewState.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import Foundation

/// Represents the UI state of the movie search screen.
///
/// Used by the view model to drive what the SwiftUI view should render.
enum MovieSearchViewState: Equatable {
    /// Results are currently being fetched from the network.
    case loading
    /// Successfully loaded a list of movies to display.
    case loaded([Movie])
    /// No results available. Includes a message suitable for user display.
    case empty(String)
    /// An error occurred while searching. Includes a user-facing error message.
    case error(String)
}
