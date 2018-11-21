//
//  ParameterEncoding.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

enum ParameterEncoding {
    case url(Parameters)
    case json(Parameters)
    case none
}

extension ParameterEncoding {
    
    func buildHTTPBody() throws -> Data? {
        switch self {
        case .json(let parameters):
            return try serializeToData(parameters: parameters)
        default:
            return nil
        }
    }
    
    func buildURL(from baseUrl: URL) throws -> URL {
        switch self {
        case .url(let parameters):
            return try createQueryURL(from: baseUrl, withParameters: parameters)
        default:
            return baseUrl
        }
    }
    
    private func createQueryURL(from baseUrl: URL, withParameters parameters: Parameters) throws -> URL {
        var urlComponents = try createURLComponents(baseUrl: baseUrl)
        let queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        urlComponents.queryItems = queryItems
        guard let urlWithQuery = urlComponents.url
            else {
                throw AppError.badRequest
        }
        return urlWithQuery
    }
    
    private func createURLComponents(baseUrl: URL) throws -> URLComponents {
        guard let urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
            else {
                throw AppError.badRequest
        }
        return urlComponents
    }
    
    private func serializeToData(parameters: Parameters) throws -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            throw AppError.badRequest
        }
    }
}
