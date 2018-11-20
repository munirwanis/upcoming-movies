//
//  NoConnectionViewController.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class NoConnectionViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var retryButton: UIButton!
    
    var retryButtonTap: Observable<Void> {
        return self.retryButton.rx.tap.asObservable()
    }
    
    init() {
        super.init(nibName: NoConnectionViewController.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.alpha = 0
        
        setTexts()
        setColors()
        
        imageView.image = #imageLiteral(resourceName: "noConnectionIcon")
        retryButton.layer.cornerRadius = 4
    }
    
    private func setTexts() {
        titleLabel.text = Strings.NoConnection.title
        descriptionLabel.text = Strings.NoConnection.description
        retryButton.setTitle(Strings.NoConnection.retry, for: .normal)
    }
    
    private func setColors() {
        view.backgroundColor = Colors.Background.white
        titleLabel.textColor = Colors.Text.black
        descriptionLabel.textColor = Colors.Text.black
        retryButton.tintColor = Colors.Text.white
        retryButton.backgroundColor = Colors.Background.green
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
