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
        
        static let primaryBlue:    UIColor? = UIColor(named: "PrimaryBlue")
        static let secondaryGreen: UIColor? = UIColor(named: "SecondaryGreen")
        static let darkBlue:       UIColor  = #colorLiteral(red: 0.168627451, green: 0.5098039216, blue: 0.5411764706, alpha: 1)
        static let white:          UIColor  = .white
        static let black:          UIColor  = .black
        static let clear:          UIColor  = .clear
    }
}

extension Colors {
    struct General {
        private init() {}
        
        static let darkBlue = Palette.darkBlue
        static let blue = Palette.primaryBlue
    }
    
    struct Background {
        static let clear = Palette.clear
        static let white = Palette.white
        static let green = Palette.secondaryGreen
    }
    
    struct Text {
        static let black = Palette.black
        static let white = Palette.white
    }
}
