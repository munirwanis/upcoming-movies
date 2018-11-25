//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol UpcomingMoviesViewModeling {
    var shouldLoadNextPage: Bool { get }
    func listUpcomingMovies() -> Observable<UpcomingMoviesState>
    func image(from path: String) -> SharedSequence<DriverSharingStrategy, UIImage>
}

final class UpcomingMoviesViewModel {
    let mapper: UpcomingMoviesMappable
    let service: UpcomingMoviesServicing
    let imageService: ImageDownloadServicing
    
    var shouldLoadNextPage: Bool = true
    
    init(mapper: UpcomingMoviesMappable, service: UpcomingMoviesServicing, imageService: ImageDownloadServicing) {
        self.mapper = mapper
        self.service = service
        self.imageService = imageService
    }
}

// MARK: - ViewModel implementation

extension UpcomingMoviesViewModel: UpcomingMoviesViewModeling {
    func listUpcomingMovies() -> Observable<UpcomingMoviesState> {
        return service.listUpcomingMovies()
            .map { [unowned self] upcoming in
                self.shouldLoadNextPage = upcoming.shouldLoadNextPage
                return self.mapper.mapToScreenState(upcoming.movies)
            }
            .catchError { [unowned self] error -> Observable<UpcomingMoviesState> in
                Observable.just(self.mapper.mapToScreenState(error))
        }
    }
    
    func image(from path: String) -> SharedSequence<DriverSharingStrategy, UIImage> {
        return imageService.backdrop(size: .medium, in: path).observeOn(MainScheduler.instance).asDriver(onErrorJustReturn: #imageLiteral(resourceName: "internalErrorIcon"))
    }
}
