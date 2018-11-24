//
//  Movie.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

typealias Movies = [Movie]

struct Movie {
    let id: String
    let name: String
    let iconPath: String
    let releaseDate: Date
}
