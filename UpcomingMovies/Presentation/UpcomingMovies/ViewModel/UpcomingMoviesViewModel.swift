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

typealias UpcomingMoviesViewModeling = UpcomingMoviesListViewModeling & UpcomingMovieImageDownloadViewModeling

protocol UpcomingMoviesListViewModeling {
    func listUpcomingMovies() -> Observable<UpcomingMoviesState>
    func image(from path: String) -> SharedSequence<DriverSharingStrategy, UIImage>
}

protocol UpcomingMovieImageDownloadViewModeling {
    func downloadImage(from path: String) -> Observable<UIImage>
}

final class UpcomingMoviesViewModel {
    let mapper: UpcomingMoviesMappable
    let service: UpcomingMoviesServicing
    let imageService: ImageDownloadServicing
    
    init(mapper: UpcomingMoviesMappable, service: UpcomingMoviesServicing, imageService: ImageDownloadServicing) {
        self.mapper = mapper
        self.service = service
        self.imageService = imageService
    }
}

// MARK: - ViewModel implementation

extension UpcomingMoviesViewModel: UpcomingMoviesListViewModeling {
    func listUpcomingMovies() -> Observable<UpcomingMoviesState> {
        return service.listUpcomingMovies()
            .map { [unowned self] movies in
                self.mapper.mapToScreenState(movies)
            }
            .catchError { [unowned self] error -> Observable<UpcomingMoviesState> in
                Observable.just(self.mapper.mapToScreenState(error))
        }
    }
    
    func image(from path: String) -> SharedSequence<DriverSharingStrategy, UIImage> {
        return imageService.backdrop(size: .medium, in: path).observeOn(MainScheduler.instance).asDriver(onErrorJustReturn: #imageLiteral(resourceName: "internalErrorIcon"))
    }
}

extension UpcomingMoviesViewModel: UpcomingMovieImageDownloadViewModeling {
    func downloadImage(from path: String) -> Observable<UIImage> {
        return imageService.poster(size: .medium, in: path)
    }
}
