//
//  MovieDetailsView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

struct MovieDetailsView: View {
    let posterURL: URL?
    let title: String
    let releaseDate: String
    let viewerRating: Double
    let formattedViewerRating: String
    let overview: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                
                HStack(alignment: .top, spacing: 8.0) {
                    MoviePosterImageView(posterURL: posterURL)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        MovieReleaseDetailsView(
                            title: title,
                            releaseDate: releaseDate
                        )
                        
                        MovieViewerRatingView(
                            viewerRating: viewerRating,
                            formattedViewerRating: formattedViewerRating
                        )
                        .padding(.trailing)
                    }
                }
                
                Divider()
                
                MovieOverviewView(overview: overview)
                    .padding([.leading, .trailing])
                
                Divider()
            }
            .padding(.leading)
            .multilineTextAlignment(.leading)
        }
    }
}
