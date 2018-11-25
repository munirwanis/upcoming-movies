//
//  UpcomingMoviesServiceMapper.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-22.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

protocol UpcomingMoviesServiceMappable {
    func mapToUpcoming(_ upcomingMoviesResponse: UpcomingMoviesResponse) -> Upcoming
}

struct UpcomingMoviesServiceMapper: UpcomingMoviesServiceMappable {
    func mapToUpcoming(_ upcomingMoviesResponse: UpcomingMoviesResponse) -> Upcoming {
        let shouldLoadNextPage = upcomingMoviesResponse.page < upcomingMoviesResponse.totalPages
        let movies = upcomingMoviesResponse.results.compactMap {
            Movie(id: $0.id,
                  name: $0.title,
                  iconPath: $0.posterPath,
                  releaseDate: $0.releaseDate,
                  overview: $0.overview)
        }
        
        return Upcoming(movies: movies, shouldLoadNextPage: shouldLoadNextPage)
    }
}
