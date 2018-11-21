//
//  Environment.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-21.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

final class Environment {
    let type: EnvironmentType
    
    enum EnvironmentType {
        case production
    }
    
    var apiKey: String {
        switch type {
        case .production: return "1f54bd990f1cdfb230adb312546d765d"
        }
    }
    
    var url: String {
        switch type {
        case .production: return "https://api.themoviedb.org/3/movie"
        }
    }
    
    private var imageURL: String {
        switch type {
        case .production: return "https://image.tmdb.org/t/p"
        }
    }
    
    func backdropImageURL(size: ImageConfiguration.BackdropSize) -> String {
        return imageURL(of: size.rawValue)
    }
    
    func posterImageURL(size: ImageConfiguration.PosterSize) -> String {
        return imageURL(of: size.rawValue)
    }
    
    private func imageURL(of size: String) -> String {
        return "\(imageURL)/\(size)"
    }
    
    init(type: EnvironmentType) {
        self.type = type
    }
}

struct ImageConfiguration {
    enum BackdropSize: String {
        case small = "w300"
        case medium = "w780"
        case large = "w1280"
        case original
    }
    
    enum PosterSize: String {
        case ultraSmall = "w92"
        case verySmall = "w154"
        case small = "w185"
        case medium = "w342"
        case large = "w500"
        case veryLarge = "w780"
        case original
    }
}
