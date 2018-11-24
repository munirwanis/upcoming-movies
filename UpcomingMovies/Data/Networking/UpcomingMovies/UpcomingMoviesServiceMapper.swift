//
//  UpcomingMoviesServiceMapper.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-22.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

protocol UpcomingMoviesServiceMappable {
    func mapToMovies(_ upcomingMoviesResponse: UpcomingMoviesResponse) -> Movies
}

struct UpcomingMoviesServiceMapper: UpcomingMoviesServiceMappable {
    func mapToMovies(_ upcomingMoviesResponse: UpcomingMoviesResponse) -> Movies {
        return []
    }
}
