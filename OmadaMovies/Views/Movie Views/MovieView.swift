//
//  MovieView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

struct MovieView: View {
    let viewModel: MovieViewModeling
    
    var body: some View {
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
            HStack(alignment: .top) {
                PosterImageView(posterURL: viewModel.posterURL)
                
                MovieReleaseDetailsView(
                    title: viewModel.title,
                    releaseDate: viewModel.releaseYear
                )
            }
        }
    }
}
