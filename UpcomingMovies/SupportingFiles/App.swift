//
//  App.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

final class App {
    private init() {
        #if DEBUG
        log = DebugLogger()
        #else
        log = MutedLogger()
        #endif
    }
    
    static let shared = App()
    let log: Logger
    let environment: Environment = .init(type: .production)
}

extension App {
    func start() {}
}
