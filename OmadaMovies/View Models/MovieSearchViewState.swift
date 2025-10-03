//
//  MovieSearchViewState.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import Foundation

enum MovieSearchViewState: Equatable {
    case loading
    case loaded([Movie])
    case empty(String)
    case error(String)
}
