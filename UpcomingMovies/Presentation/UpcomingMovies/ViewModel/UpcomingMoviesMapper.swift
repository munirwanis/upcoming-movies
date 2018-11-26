//
//  UpcomingMoviesMapper.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

protocol UpcomingMoviesMappable {
    func mapToScreenState(_ movies: Movies) -> UpcomingMoviesState
    func mapToScreenState(_ error: Error) -> UpcomingMoviesState
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
                               genres: $0.genres)
        }
    }
    
    private func mapToUpcomingMoviesErrorState(_ error: AppError) -> UpcomingMoviesErrorState {
        switch error {
        case .connection: return .network
        default: return .general
        }
    }
}
