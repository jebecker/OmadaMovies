//
//  MoviePosterImageView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

struct MoviePosterImageView: View {
    let posterURL: URL?
    
    var body: some View {
        // Scroll performance is acceptable because we are requesting a 300 pixel wide image from the server which roughly matches the desired frame below
        // In order to entirely eliminate scroll performance issues, an image downloading, resizing and caching system would need to be created to do all computation on a background thread
        // Then the finished image would be sent back to the ImageView completely configured with no scaling and rendering on the main thread
        AsyncImage(url: posterURL) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 100)
                .padding([.leading, .trailing, .bottom])
        } placeholder: {
            Image(systemName: "movieclapper")
                .font(.system(size: 64))
                .frame(width: 100, height: 150)
                .background(Color.gray)
                .padding([.leading, .trailing, .bottom])
        }
    }
}
