//
//  Colors.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

struct Colors {
    private init() {}
    
    private struct Palette {
        private init() {}
        
        static let primaryBlue = UIColor(named: "PrimaryBlue")
        static let secondaryGreen = UIColor(named: "SecondaryGreen")
        static let white = UIColor.white
        static let black = UIColor.black
    }
}

extension Colors {
    struct General {
        private init() {}
        
        static let blue = Palette.primaryBlue
    }
    
    struct Background {
        static let white = Palette.white
        static let green = Palette.secondaryGreen
    }
    
    struct Text {
        static let black = Palette.black
        static let white = Palette.white
    }
}
