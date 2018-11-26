//
//  MovieModel.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

struct MovieModel: AppEvent {
    let name: String
    let iconImage: UIImage?
    let backdropImage: UIImage?
    let releaseDate: String
    let genres: [String]
    let overview: String
}
