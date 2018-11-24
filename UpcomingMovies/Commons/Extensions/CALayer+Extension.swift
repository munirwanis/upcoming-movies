//
//  CALayer+Extension.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

extension CALayer {
    
    func applyShadow(
        color:  UIColor? = Colors.General.darkBlue,
        alpha:  Float = 0.5,
        x:      CGFloat = 0,
        y:      CGFloat = 3,
        blur:   CGFloat = 10,
        spread: CGFloat = 0) {
        
        shadowColor = color?.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
