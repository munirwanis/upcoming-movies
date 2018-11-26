//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

internal class MutedLogger: Logger {
    func info(_ message: String, data: Data?) {}
    func info(_ message: String) {}
    
    func warning(_ message: String, data: Data?) {}
    func warning(_ message: String) {}
    
    func error(_ message: String, error: Error?, data: Data?) {}
    func error(_ message: String, error: Error?) {}
    func error(_ message: String) {}
}
