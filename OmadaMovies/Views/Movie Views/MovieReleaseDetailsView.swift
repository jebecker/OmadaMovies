//
//  MovieReleaseDetailsView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

/// Displays a movie's title and release date in a vertically stacked layout.
/// Use this for compact headers in detail screens or list rows where you want
/// a bold title and a secondary-styled date.
struct MovieReleaseDetailsView: View {
    /// The display title of the movie.
    let title: String
    /// A pre-formatted release date string (e.g., "Oct 3, 2025").
    let releaseDate: String
    
    var body: some View {
        VStack(alignment: .leading) {
            // Prominent movie title.
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            // Secondary, caption-styled release date.
            Text(releaseDate)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
