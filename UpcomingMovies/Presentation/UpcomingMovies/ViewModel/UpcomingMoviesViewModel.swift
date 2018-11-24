//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation
import RxSwift

protocol UpcomingMoviesViewModeling {
    func listUpcomingMovies() -> Observable<UpcomingMoviesState>
}

final class UpcomingMoviesViewModel {
    let mapper: UpcomingMoviesMappable
    let service: UpcomingMoviesServicing
    
    init(mapper: UpcomingMoviesMappable, service: UpcomingMoviesServicing) {
        self.mapper = mapper
        self.service = service
    }
}

// MARK: - ViewModel implementation

extension UpcomingMoviesViewModel: UpcomingMoviesViewModeling {
    func listUpcomingMovies() -> Observable<UpcomingMoviesState> {
        return service.listUpcomingMovies()
            .map { [unowned self] movies in
                self.mapper.mapToScreenState(movies)
            }
            .catchError { [unowned self] error -> Observable<UpcomingMoviesState> in
                Observable.just(self.mapper.mapToScreenState(error))
        }
    }
}
