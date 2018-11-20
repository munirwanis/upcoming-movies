//
//  LoadingViewController.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    init() {
        super.init(nibName: LoadingViewController.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.alpha = 0
    }
    
    func show() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.alpha = 1
            self?.activityIndicator.startAnimating()
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.alpha = 0
            self?.activityIndicator.stopAnimating()
        }
    }
}
