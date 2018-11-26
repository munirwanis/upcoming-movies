//
//  GenresResponse.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genre]
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}
