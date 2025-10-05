//
//  MoviePosterImageView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/4/25.
//

import SwiftUI

/// Renders a movie poster image loaded asynchronously with a placeholder while loading.
///
/// Optimized for scrolling lists by requesting a moderately sized (w300) image from TMDB.
/// In order to entirely eliminate scroll performance issues, an image downloading, resizing and caching system would need to be created to do all computation on a background thread
/// Then the finished image would be sent back to the ImageView completely configured with no scaling and rendering on the main thread
struct MoviePosterImageView: View {
    /// The URL of the poster image to display. If `nil`, only the placeholder is shown.
    let posterURL: URL?
    
    var body: some View {
        // Asynchronously load the poster image and show a placeholder while loading.
        AsyncImage(url: posterURL) { image in
            // Loaded image content and styling.
            image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 150)
                .padding([.leading, .trailing, .bottom])
        } placeholder: {
            // Placeholder shown while the poster image is loading or unavailable.
            Image(systemName: "movieclapper")
                .font(.system(size: 64))
                .frame(width: 100, height: 150)
                .background(Color.gray)
                .padding([.leading, .trailing, .bottom])
        }
    }
}
