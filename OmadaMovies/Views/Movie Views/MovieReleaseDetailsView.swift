//
//  MovieReleaseDetailsView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

struct MovieReleaseDetailsView: View {
    let title: String
    let releaseDate: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text(releaseDate)
                .font(.subheadline)
        }
    }
}

