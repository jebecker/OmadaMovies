//
//  ContentView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let client = MoviesSearchClient()
    
    var body: some View {
        VStack {
            Text("Hello world!")
        }
        .task {
            let movies = try? await client.searchMovies(query: "Avengers")
            
            print(movies)
        }
    }

}

