//
//  OmadaMoviesApp.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import SwiftUI

/// The main entry point for the OmadaMovies app.
/// Defines the root scene and sets `MovieSearchView` as the initial screen.
struct OmadaMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MovieSearchView()
        }
    }
}
