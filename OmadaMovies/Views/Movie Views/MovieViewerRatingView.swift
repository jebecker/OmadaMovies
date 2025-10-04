//
//  MovieViewerRatingView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

struct MovieViewerRatingView: View {
    let viewerRating: Double
    let formattedViewerRating: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Viewer Rating")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            ProgressView(value: viewerRating, total: 10) {
                Text(formattedViewerRating)
                    .fontWeight(.bold)
            }
        }
    }
}
