//
//  UpcomingMoviesState.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

enum UpcomingMoviesState {
    case firstLoading
    case loading
    case succcess(UpcomingMoviesModel)
    case error(UpcomingMoviesErrorState)
}
