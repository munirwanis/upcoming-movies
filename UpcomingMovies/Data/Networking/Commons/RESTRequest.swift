//
//  RESTRequest.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

struct RESTRequest {
    let verb: RESTVerb
    let url: String
    let parametersEncoding: ParameterEncoding
    let headers: Headers?
}
