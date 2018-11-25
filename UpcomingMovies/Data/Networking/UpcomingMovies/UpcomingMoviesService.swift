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
    func listUpcomingMovies() -> Observable<Upcoming>
}

final class UpcomingMoviesService: RESTService {
    let mapper: UpcomingMoviesServiceMappable
    var currentPage: Int = 1
    
    init(mapper: UpcomingMoviesServiceMappable) {
        self.mapper = mapper
    }
}

// MARK: - Service implementation

extension UpcomingMoviesService: UpcomingMoviesServicing {
    func listUpcomingMovies() -> Observable<Upcoming> {
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
            .map { [unowned self] (response: UpcomingMoviesResponse) -> Upcoming in
                if self.currentPage < response.totalPages {
                    self.currentPage = response.page + 1
                }
                return self.mapper.mapToUpcoming(response)
            }
    }
}
