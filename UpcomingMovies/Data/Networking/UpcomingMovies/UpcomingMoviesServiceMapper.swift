//
//  UpcomingMoviesServiceMapper.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-22.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

protocol UpcomingMoviesServiceMappable {
    func mapToUpcoming(_ upcomingMoviesResponse: UpcomingMoviesResponse) throws -> Upcoming
}

struct UpcomingMoviesServiceMapper: UpcomingMoviesServiceMappable {
    let genreDatabase: GenresDatabasing
    
    init(database: GenresDatabasing) {
        self.genreDatabase = database
    }
    
    func mapToUpcoming(_ upcomingMoviesResponse: UpcomingMoviesResponse) throws -> Upcoming {
        let genres = try genreDatabase.listGenres().genres
        
        let shouldLoadNextPage = upcomingMoviesResponse.page < upcomingMoviesResponse.totalPages
        
        let movies: Movies = upcomingMoviesResponse.results.compactMap { upcomingMovie in
            var genresFound = [String]()
            
            upcomingMovie.genreIds.forEach { id in
                genresFound.append(contentsOf: genres.filter { genre in genre.id == id }.map { genre in genre.name })
            }
            
            return Movie(id: upcomingMovie.id,
                         name: upcomingMovie.title,
                         iconPath: upcomingMovie.posterPath,
                         backdropPath: upcomingMovie.backdropPath,
                         releaseDate: upcomingMovie.releaseDate,
                         overview: upcomingMovie.overview,
                         genres: genresFound)
        }
        
        return Upcoming(movies: movies, shouldLoadNextPage: shouldLoadNextPage)
    }
}
