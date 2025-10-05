//
//  MovieViewerRatingView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

/// Displays a viewer rating with a label and progress bar.
/// Expects a 0–10 scale and a pre-formatted string for display (e.g., "7.8/10").
struct MovieViewerRatingView: View {
    /// The numeric viewer rating on a 0–10 scale used to drive the progress bar.
    let viewerRating: Double
    /// A pre-formatted rating string to show alongside the progress (e.g., "7.8/10").
    let formattedViewerRating: String

    var body: some View {
        VStack(alignment: .leading) {
            // Section label shown above the progress indicator.
            Text("Viewer Rating")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            // Progress reflects the rating out of 10; the label shows the formatted value.
            ProgressView(value: viewerRating, total: 10) {
                Text(formattedViewerRating)
                    .fontWeight(.bold)
            }
        }
    }
}
