//
//  InternalOrServerErrorViewController.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

final class InternalOrServerErrorViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    init() {
        super.init(nibName: InternalOrServerErrorViewController.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.alpha = 0
        
        setTexts()
        setColors()
        
        imageView.image = #imageLiteral(resourceName: "internalErrorIcon")
    }
    
    private func setTexts() {
        titleLabel.text = Strings.InternalError.title
        descriptionLabel.text = Strings.InternalError.description
    }
    
    private func setColors() {
        view.backgroundColor = Colors.Background.white
        titleLabel.textColor = Colors.Text.black
        descriptionLabel.textColor = Colors.Text.black
    }
    
    func show() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.alpha = 0
        }
    }
}
