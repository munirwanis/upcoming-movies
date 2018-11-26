//
//  UpcomingMoviesResponse.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-22.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

struct UpcomingMoviesResponse: Decodable {
    let results: [MovieResponse]
    let totalPages: Int
    let page: Int
    
    struct MovieResponse: Decodable {
        let id: Int
        let title: String
        let posterPath: String?
        let backdropPath: String?
        let releaseDate: Date
        let genreIds: [Int]
        let overview: String
    }
}
