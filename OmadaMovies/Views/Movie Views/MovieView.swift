//
//  MovieView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

/// A row-style view that presents a movie's poster and basic details.
/// Tapping the row navigates to a full details screen.
struct MovieView: View {
    /// Provides the data needed to render the row and navigate to details.
    let viewModel: MovieViewModeling
    
    var body: some View {
        // Navigate to the detailed movie screen when the row is tapped.
        NavigationLink {
            MovieDetailsView(
                posterURL: viewModel.posterURL,
                title: viewModel.title,
                releaseDate: viewModel.releaseDate,
                viewerRating: viewModel.viewerRating,
                formattedViewerRating: viewModel.formattedViewerRating,
                overview: viewModel.overview
            )
        } label: {
            // Row layout: poster thumbnail on the left, text details on the right.
            HStack(alignment: .top) {
                MoviePosterImageView(posterURL: viewModel.posterURL)
                
                MovieReleaseDetailsView(
                    title: viewModel.title,
                    releaseDate: viewModel.releaseYear
                )
            }
        }
    }
}
