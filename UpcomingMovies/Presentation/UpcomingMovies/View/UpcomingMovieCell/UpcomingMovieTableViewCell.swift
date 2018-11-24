//
//  UpcomingMovieTableViewCell.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class UpcomingMovieTableViewCell: UITableViewCell {
    @IBOutlet private var cardView: UIView!
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    @IBOutlet private var releaseDateValueLabel: UILabel!
    @IBOutlet private var genresLabel: UILabel!
    @IBOutlet private var genresValueLabel: UILabel!
    
    private(set) var bag = DisposeBag()
    private let downloadPhotoTrigger = PublishSubject<String>()
    
    var upcomingMovie: UpcomingMovieModel? {
        didSet {
            setValues()
        }
    }
    
    var movieIcon: UIImage? {
        didSet {
            posterImageView.image = movieIcon
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func prepareForReuse() {
        bag = DisposeBag()
    }
}

// MARK: - Setup

extension UpcomingMovieTableViewCell {
    private func setup() {
        setupColors()
        setupTexts()
        setupLayout()
    }
    
    // MARK: - Colors
    
    private func setupColors() {
        backgroundColor = Colors.Background.clear
    }
    
    // MARK: - Texts
    
    private func setupTexts() {
        releaseDateLabel.text = Strings.UpcomingMovies.releaseDate
        genresLabel.text = Strings.UpcomingMovies.genres
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        cardView.layer.cornerRadius = 8.0
        cardView.layer.applyShadow()
    }
    
    private func setValues() {
        guard let upcomingMovie = self.upcomingMovie else { return }
        nameLabel.text = upcomingMovie.name
        releaseDateValueLabel.text = upcomingMovie.releaseDate
    }
}
