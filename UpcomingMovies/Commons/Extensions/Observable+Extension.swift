//
//  Observable+Extension.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation
import RxSwift

extension Observable where Element: OptionalType {
    /// Returns an Observable where the nil values from the original Observable are
    /// skipped
    func unwrap() -> Observable<Element.Wrapped> {
        return self.filter { $0.asOptional != nil }.map { $0.asOptional! }
    }
}

/// Represent an optional value
///
/// This is needed to restrict our Observable extension to Observable that generate
/// .Next events with Optional payload
protocol OptionalType {
    associatedtype Wrapped
    var asOptional:  Wrapped? { get }
}

/// Implementation of the OptionalType protocol by the Optional type
extension Optional: OptionalType {
    var asOptional: Wrapped? { return self }
}
