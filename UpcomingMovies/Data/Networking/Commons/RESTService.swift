//
//  BaseRequest.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

typealias Parameters = [String : Any]
typealias Headers = [String : String]

class RESTService {
    
    func requestData(with restRequest: RESTRequest) -> Observable<Data> {
        
        do {
            let urlRequest = try createRequest(from: restRequest)
            let url = urlRequest.url?.absoluteString ?? ""
            
            return Alamofire.SessionManager.default
                .rx
                .request(urlRequest: urlRequest)
                .observeOn(MainScheduler.instance)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .validate({ (_, response, data) in
                    App.shared.log.info("Request to: \(url)", data: data)
                    return self.validate(from: response)
                })
                .responseData()
                .do(onError: { [unowned self] error in
                    App.shared.log.error("Error from \(url)", error: error)
                    try self.handle(error)
                })
                .map({ _, jsonData in
                    jsonData
                })
            
        } catch {
            return Observable.error(error)
        }
    }
    
    private func createRequest(from request: RESTRequest) throws -> URLRequest {
        
        guard let baseUrl = URL(string: request.url) else {
            throw AppError.badRequest
        }
        
        let url = try request.parametersEncoding.buildURL(from: baseUrl)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.verb.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = try request.parametersEncoding.buildHTTPBody()
        
        return urlRequest
    }
}

// MARK: - Handling

extension RESTService {
    private func validate(from response: HTTPURLResponse) -> Request.ValidationResult {
        do {
            try verifyStatusCode(from: response)
            return .success
        }
        catch {
            return .failure(error)
        }
    }
    
    private func verifyStatusCode(from response: HTTPURLResponse) throws {
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            let serviceError = error(from: response.statusCode)
            throw serviceError
        }
    }
    
    private func error(from statusCode: Int) -> AppError {
        switch statusCode {
        case 400...499:
            return .badRequest
        default:
            return .internal
        }
    }
    
    private func handle(_ error: Error) throws {
        switch error {
        case is URLError: throw AppError.connection
        default: throw error
        }
    }
}
