//
//  MovieTableViewCell.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet private var label: UILabel!
    
    var titleText: String? {
        didSet {
            label.text = titleText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
