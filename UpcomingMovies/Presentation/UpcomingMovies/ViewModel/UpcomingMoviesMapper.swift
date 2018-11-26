//
//  UpcomingMoviesMapper.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

protocol UpcomingMoviesMappable {
    func mapToScreenState(_ movies: Movies) -> UpcomingMoviesState
    func mapToScreenState(_ error: Error) -> UpcomingMoviesState
    func mapToMovieModel(_ upcoming: UpcomingMovieModel, with images: (posterImage: UIImage?, backdropImage: UIImage?)) -> MovieModel
}

struct UpcomingMoviesMapper: UpcomingMoviesMappable {
    func mapToScreenState(_ movies: Movies) -> UpcomingMoviesState {
        let upcomingMovies = mapToUpcomingMovies(movies)
        return .succcess(upcomingMovies)
    }
    
    func mapToScreenState(_ error: Error) -> UpcomingMoviesState {
        switch error as? AppError {
        case .none: return .error(.general)
        case .some(let appError): return .error(mapToUpcomingMoviesErrorState(appError))
        }
    }
    
    func mapToMovieModel(_ upcoming: UpcomingMovieModel, with images: (posterImage: UIImage?, backdropImage: UIImage?)) -> MovieModel {
        return MovieModel(name: upcoming.name,
                          iconImage: images.posterImage,
                          backdropImage: images.backdropImage,
                          releaseDate: upcoming.releaseDate,
                          genres: upcoming.genres,
                          overview: upcoming.overview)
    }
}

// MARK: - Private mappers

extension UpcomingMoviesMapper {
    private func mapToUpcomingMovies(_ movies: Movies) -> UpcomingMoviesModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return movies.map {
            UpcomingMovieModel(id: $0.id,
                               name: $0.name,
                               iconPath: $0.iconPath,
                               backdropPath: $0.backdropPath,
                               releaseDate: dateFormatter.string(from: $0.releaseDate),
                               genres: $0.genres,
                               overview: $0.overview)
        }
    }
    
    private func mapToUpcomingMoviesErrorState(_ error: AppError) -> UpcomingMoviesErrorState {
        switch error {
        case .connection: return .network
        default: return .general
        }
    }
}
