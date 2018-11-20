//
//  NSObject+Extension.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable where Self: NSObject {

    static var identifier: String { return String(describing: self) }

    var applicationName: String? {
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
}

extension NSObject: Reusable {}
