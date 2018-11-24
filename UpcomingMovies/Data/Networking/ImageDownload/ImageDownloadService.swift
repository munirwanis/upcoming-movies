//
//  ImageDownloadService.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-22.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit
import RxSwift

protocol ImageDownloadServicing {
    func backdrop(size: ImageConfiguration.BackdropSize, in path: String) -> Observable<UIImage>
    func poster(size: ImageConfiguration.PosterSize, in path: String) -> Observable<UIImage>
}

final class ImageDownloadService: RESTService {}

// MARK: - Service implementation

extension ImageDownloadService: ImageDownloadServicing {
    func backdrop(size: ImageConfiguration.BackdropSize, in path: String) -> Observable<UIImage> {
        let url = "\(App.shared.environment.backdropImageURL(size: size))\(path)"
        return requestImage(from: url)
            .catchError { _ -> Observable<UIImage> in
                return Observable.just(#imageLiteral(resourceName: "internalErrorIcon"))
        }
    }
    
    func poster(size: ImageConfiguration.PosterSize, in path: String) -> Observable<UIImage> {
        let url = "\(App.shared.environment.posterImageURL(size: size))\(path)"
        return requestImage(from: url)
            .catchError { _ -> Observable<UIImage> in
                return Observable.just(#imageLiteral(resourceName: "internalErrorIcon"))
        }
    }
}
