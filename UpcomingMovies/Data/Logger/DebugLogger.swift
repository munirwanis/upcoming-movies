//
//  DebugLogger.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

internal class DebugLogger: Logger {
    
    private enum LogType {
        case info(Data?)
        case warning(Data?)
        case error(Error?, Data?)
        
        var tag: String {
            switch self {
            case .info: return "[ℹ️ INFO]"
            case .warning: return "[⚠️ WARNING]"
            case .error: return "[🚫 ERROR]"
            }
        }
    }
    
    func warning(_ message: String, data: Data?) {
        log(.warning(data), message)
    }
    
    func warning(_ message: String) {
        log(.warning(nil), message)
    }
    
    func error(_ message: String, error: Error?, data: Data?) {
        log(.error(error, data), message)
    }
    
    func error(_ message: String, error: Error?) {
        log(.error(error, nil), message)
    }
    
    func error(_ message: String) {
        log(.error(nil, nil), message)
    }
    
    func info(_ message: String, data: Data?) {
        log(.info(data), message)
    }
    
    func info(_ message: String) {
        log(.info(nil), message)
    }
    
    private func log(_ type: LogType, _ message: String) {
        var dataString: String?
        var error: Error?
        
        switch type {
        case .info(let data): dataString = string(from: data)
        case .warning(let data): dataString = string(from: data)
        case .error(let errorType, let data): dataString = string(from: data); error = errorType
        }
        
        print("\(type.tag) \(message)")
        
        if let error = error {
            print(error)
        }
        
        if let dataString = dataString {
            print(dataString)
        }
    }
    
    private func string(from data: Data?) -> String? {
        if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data),
            let prettyJSON = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(data: prettyJSON, encoding: .utf8)
        } else {
            return nil
        }
    }
}
