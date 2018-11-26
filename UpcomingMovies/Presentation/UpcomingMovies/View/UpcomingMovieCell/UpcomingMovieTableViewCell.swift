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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        paintSelectedCard(selected)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        paintSelectedCard(highlighted)
    }
    
    private func paintSelectedCard(_ selected: Bool) {
        if selected {
            cardView.backgroundColor = Colors.General.darkBlue
            nameLabel.textColor = Colors.Text.white
            genresLabel.textColor = Colors.Text.white
            releaseDateLabel.textColor = Colors.Text.white
            releaseDateValueLabel.textColor = Colors.Text.white
            genresValueLabel.textColor = Colors.Text.white
        } else {
            cardView.backgroundColor = Colors.Background.white
            nameLabel.textColor = Colors.Text.black
            genresLabel.textColor = Colors.Text.black
            releaseDateLabel.textColor = Colors.Text.black
            releaseDateValueLabel.textColor = Colors.Text.black
            genresValueLabel.textColor = Colors.Text.black
        }
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
        genresValueLabel.text = upcomingMovie.genres.joined(separator: ", ")
    }
}
