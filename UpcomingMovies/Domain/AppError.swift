//
//  AppError.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

enum AppError: Error {
    case connection
    case serialization
    case `internal`
    case badRequest
}
