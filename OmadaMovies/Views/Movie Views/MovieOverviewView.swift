//
//  MovieOverviewView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

struct MovieOverviewView: View {
    let overview: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text("OVERVIEW")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            Text(overview)
                .font(.body)
                .foregroundStyle(.primary)
        }
    }
}
