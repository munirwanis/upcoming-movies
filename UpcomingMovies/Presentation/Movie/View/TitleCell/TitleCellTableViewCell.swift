//
//  TitleCellTableViewCell.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

final class TitleCellTableViewCell: UITableViewCell {
    @IBOutlet private var label: UILabel!
    
    var titleText: String? {
        didSet {
            label.text = titleText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        backgroundColor = Colors.General.darkBlue
        label.textColor = Colors.Text.white
    }}
