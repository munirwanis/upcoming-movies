//
//  UpcomingMoviesService.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-22.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation
import RxSwift

protocol UpcomingMoviesServicing {
    func listUpcomingMovies() -> Observable<Movies>
}

final class UpcomingMoviesService: RESTService {
    let mapper: UpcomingMoviesServiceMappable
    var currentPage: Int = 1
    var totalPages: Int = 1
    
    init(mapper: UpcomingMoviesServiceMappable) {
        self.mapper = mapper
    }
}

// MARK: - Service implementation

extension UpcomingMoviesService: UpcomingMoviesServicing {
    func listUpcomingMovies() -> Observable<Movies> {
        let url = "\(App.shared.environment.url)/upcoming"
        let parameters: JSON = [
            "api_key": App.shared.environment.apiKey,
            "language": "en-US",
            "page": currentPage
        ]
        
        let apiRequest = RESTRequest(verb: .get,
                                     url: url,
                                     parametersEncoding: .url(parameters),
                                     headers: nil)
        
        return request(with: apiRequest)
            .map { [unowned self] (response: UpcomingMoviesResponse) -> Movies in
                self.totalPages = response.totalPages
                if self.totalPages == self.currentPage { return [] }
                return self.mapper.mapToMovies(response)
            }
            .scan([]) { [unowned self] (previous, current) -> Movies in
                if self.currentPage < self.totalPages {
                    self.currentPage += 1
                }
                return previous + current
        }
    }
}
