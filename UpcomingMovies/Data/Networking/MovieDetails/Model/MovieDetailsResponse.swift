//
//  MovieDetailsResponse.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

struct MovieDetailsResponse: Decodable {
    let title: String
    let posterPath: String
    let backdropPath: String
    let genres: [MovieDetailsResponse.Genre]
    let overview: String
    let releaseDate: Date
    
    struct Genre: Decodable {
        let name: String
    }
}
