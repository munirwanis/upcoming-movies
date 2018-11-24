//
//  MovieDetailsServiceMapper.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

protocol MovieDetailsServiceMappable {
    func mapToMovieDetails(_ movieDetailsResponse: MovieDetailsResponse) -> MovieDetails
}

struct MovieDetailsMapper: MovieDetailsServiceMappable {
    func mapToMovieDetails(_ movieDetailsResponse: MovieDetailsResponse) -> MovieDetails {
        let genres = movieDetailsResponse.genres.map { $0.name }
        return MovieDetails(name: movieDetailsResponse.title,
                            posterPath: movieDetailsResponse.posterPath,
                            backdropPath: movieDetailsResponse.backdropPath,
                            genres: genres,
                            overview: movieDetailsResponse.overview,
                            releaseDate: movieDetailsResponse.releaseDate)
    }
}
