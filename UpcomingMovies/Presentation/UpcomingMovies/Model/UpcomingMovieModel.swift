//
//  UpcomingMovieModel.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

typealias UpcomingMoviesModel = [UpcomingMovieModel]

struct UpcomingMovieModel {
    let id: Int
    let name: String
    let iconPath: String?
    let releaseDate: String
    let genres: [String]
}
