//
//  MovieOverviewView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

/// Displays the movie's overview/synopsis with a section header and body text.
struct MovieOverviewView: View {
    /// The overview/synopsis text to display.
    let overview: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            // Section header label.
            Text("OVERVIEW")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            // Text for the movie description.
            Text(overview)
                .font(.body)
                .foregroundStyle(.primary)
        }
    }
}
