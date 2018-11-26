//
//  MovieDetailsService.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDetailsServicing {
    func getMovieDetails(from id: String) -> Observable<MovieDetails>
}

final class MovieDetailsService: RESTService {
    let mapper: MovieDetailsServiceMappable
    
    init(mapper: MovieDetailsServiceMappable) {
        self.mapper = mapper
    }
}

// MARK: - Service implementation

extension MovieDetailsService: MovieDetailsServicing {
    func getMovieDetails(from id: String) -> Observable<MovieDetails> {
        let url = "\(App.shared.environment.url)/\(id)"
        let parameters: JSON = [
            "api_key": App.shared.environment.apiKey,
            "language": "en-US"
        ]
        
        let apiRequest = RESTRequest(verb: .get,
                                     url: url,
                                     parametersEncoding: .url(parameters),
                                     headers: nil)
        
        return request(with: apiRequest)
            .map { [unowned self] (response: MovieDetailsResponse) -> MovieDetails in
                self.mapper.mapToMovieDetails(response)
        }
    }
}
