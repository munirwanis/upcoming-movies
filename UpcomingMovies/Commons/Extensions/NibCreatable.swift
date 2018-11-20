//
//  NibCreatable.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

/// `NibCreatable` provides an easy way to create Nibs.
protocol NibCreatable {
    
    func makeNib<T: UIView>(for type: T.Type) -> UINib
}

extension NibCreatable {
    
    /// Allows create a `UINib` just passing the `class` type.
    ///
    /// - Parameter type: The type to create the `UINib`.
    /// - Returns: Returns a `UINib`.
    public func makeNib<T: UIView>(for type: T.Type) -> UINib {
        
        let bundle = Bundle(for: type.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)
        
        return nib
    }
}
