//
//  Strings.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

struct Strings {
    private init() {}
    
    struct Movie {
        private init() {}
        
        static let overview = "movie-overview".localized
        static let releaseDate = "movie-release-date".localized
        static let genres = "movie-genres".localized
    }
    
    struct UpcomingMovies {
        private init() {}
        
        static let releaseDate = "upcoming-movies-release-date".localized
        static let genres = "upcoming-movies-genres".localized
        static let title = "upcoming-movies-title".localized
    }
    
    struct NoConnection {
        private init() {}
        
        static let title = "no-connection-title".localized
        static let description = "no-connection-description".localized
        static let retry = "no-connection-retry".localized
    }
    
    struct InternalError {
        private init() {}
        
        static let title = "internal-error-title".localized
        static let description = "internal-error-description".localized
    }
}
