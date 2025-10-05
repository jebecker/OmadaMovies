//
//  MovieDetailsView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

/// Displays detailed information for a movie, including poster, title, release date, rating, and overview.
///
/// Composes several smaller views to present content in a scrollable layout.
struct MovieDetailsView: View {
    /// URL for the movie's poster image, if available.
    let posterURL: URL?
    /// Display title of the movie.
    let title: String
    /// Localized, human-readable release date.
    let releaseDate: String
    /// Raw average viewer rating on a 0–10 scale.
    let viewerRating: Double
    /// User-facing rating string (e.g., "7.8/10").
    let formattedViewerRating: String
    /// Synopsis/description of the movie.
    let overview: String
    
    var body: some View {
        ScrollView {
            // Main vertical layout for the page content.
            VStack(alignment: .leading) {
                Divider()
                
                // Poster on the left, details on the right.
                HStack(alignment: .top, spacing: 8.0) {
                    // Movie poster image.
                    MoviePosterImageView(posterURL: posterURL)
                    
                    // Title/release details and viewer rating.
                    VStack(alignment: .leading, spacing: 16.0) {
                        MovieReleaseDetailsView(
                            title: title,
                            releaseDate: releaseDate
                        )
                        .padding(.trailing)
                        
                        MovieViewerRatingView(
                            viewerRating: viewerRating,
                            formattedViewerRating: formattedViewerRating
                        )
                        .padding(.trailing)
                    }
                }
                
                Divider()
                
                // Overview/synopsis content.
                MovieOverviewView(overview: overview)
                    .padding([.leading, .trailing])
                
                Divider()
            }
            .padding(.leading)
            .multilineTextAlignment(.leading)
        }
    }
}
