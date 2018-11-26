//
//  MovieTableViewController.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import ParallaxHeader
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class MovieTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!
    private let movie: MovieModel
    private var list = [(text: String, type: UITableViewCell.Type)]()
    
    init(movie: MovieModel) {
        self.movie = movie
        list.append((Strings.Movie.overview, TitleCellTableViewCell.self))
        list.append((movie.overview, MovieTableViewCell.self))
        list.append((Strings.Movie.releaseDate, TitleCellTableViewCell.self))
        list.append((movie.releaseDate, MovieTableViewCell.self))
        list.append((Strings.Movie.genres, TitleCellTableViewCell.self))
        list.append(contentsOf: movie.genres.map { ($0, MovieTableViewCell.self) })
        
        super.init(nibName: MovieTableViewController.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

extension MovieTableViewController {
    private func setup() {
            setupTableView()
            setupColors()
            setupTexts()
    }
    
    // MARK: - TableView
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellNib: MovieTableViewCell.self)
        tableView.register(cellNib: TitleCellTableViewCell.self)
        
        let image = movie.backdropImage
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        imageView.blurView.setup(style: .dark, alpha: 1).enable()
        
        tableView.parallaxHeader.view = imageView
        tableView.parallaxHeader.height = 400
        tableView.parallaxHeader.minimumHeight = 120
        tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
        
        let roundIcon = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100)
        )
        roundIcon.contentMode = .scaleAspectFill
        roundIcon.image = movie.iconImage
        roundIcon.layer.borderColor = UIColor.white.cgColor
        roundIcon.layer.borderWidth = 2
        roundIcon.layer.cornerRadius = roundIcon.frame.width / 2
        roundIcon.clipsToBounds = true
        
        //add round image view to blur content view
        //do not use vibrancyContentView to prevent vibrant effect
        imageView.blurView.blurContentView?.addSubview(roundIcon)
        //add constraints using SnpaKit library
        roundIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    // MARK: - Colors
    
    private func setupColors() {
        tableView.backgroundColor = Colors.General.darkBlue
    }
    
    // MARK: - Texts
    
    private func setupTexts() {
        title = movie.name
    }
}

// MARK: - Life Cycle

extension MovieTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Table view data source

extension MovieTableViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.row]
        switch item.type {
        case is MovieTableViewCell.Type:
            let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleText = item.text
            return cell
        case is TitleCellTableViewCell.Type:
            let cell: TitleCellTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleText = item.text
            return cell
        default:
            return UITableViewCell()
        }
    }
}
