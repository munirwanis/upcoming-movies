//
//  UpcomingMoviesTableViewController.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class UpcomingMoviesTableViewController: UIViewController, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!
    
    private let bag = DisposeBag()
    private let viewModel: UpcomingMoviesViewModeling
    private let upcomingMoviesSubject = PublishSubject<UpcomingMoviesModel>()
    private var upcomingMovies = UpcomingMoviesModel()
    private let errorView = InternalOrServerErrorViewController()
    private let loadingView = LoadingViewController()
    private let noConnectionView = NoConnectionViewController()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init(viewModel: UpcomingMoviesViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: UpcomingMoviesTableViewController.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Life Cycle

extension UpcomingMoviesTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - Setup

extension UpcomingMoviesTableViewController {
    private func setup() {
        setupTableView()
        setupColors()
        setupTexts()
        setupNavigation()
        
        handleUpcomingMovies()
    }
    
    // MARK: - TableView
    
    private func setupTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.register(cellNib: UpcomingMovieTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
    }
    
    // MARK: - Navigation
    
    private func setupNavigation() {
        let rightBarButton = UIBarButtonItem(customView: loadingIndicator)
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    // MARK: - Colors
    
    private func setupColors() {
        tableView.backgroundColor = Colors.Background.green
    }
    
    // MARK: - Texts
    
    private func setupTexts() {
        title = Strings.UpcomingMovies.title
    }
}

// MARK: - Handlers

extension UpcomingMoviesTableViewController {
    private func handleUpcomingMovies() {
        upcomingMoviesSubject.asObserver()
            .scan([]) { (previous, current) -> UpcomingMoviesModel in
                previous + current
            }
            .bind(to: tableView.rx.items(cellIdentifier: UpcomingMovieTableViewCell.identifier,
                                         cellType: UpcomingMovieTableViewCell.self)) { [unowned self] _, element, cell in
                                            cell.upcomingMovie = element
                                            self.viewModel.posterImage(from: element.iconPath ?? "")
                                                .drive(onNext: { image in
                                                    cell.movieIcon = image
                                                })
                                                .disposed(by: cell.bag)
                                            self.viewModel.backdropImage(from: element.backdropPath ?? "")
                                                .drive(onNext: { image in
                                                    cell.movieBackdrop = image
                                                })
                                                .disposed(by: cell.bag)
            }
            .disposed(by: self.bag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let _ = self.tableView.cellForRow(at: indexPath) as? UpcomingMovieTableViewCell
                let controller = MovieTableViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            })
            .disposed(by: bag)
        
        let noConnectionRetryObservable = noConnectionView.retryButtonTap.flatMap { [unowned self] _ -> Observable<UpcomingMoviesState> in
            self.noConnectionView.hide()
            return self.viewModel.listUpcomingMovies().startWith(.firstLoading)
        }
        
        let contentOffsetObservable = tableView.rx.contentOffset
            .debounce(0.3, scheduler: MainScheduler.instance)
            .skip(1) // skips the first from the loading
            .flatMap { [unowned self] offset in
                self.tableView.isNearBottomEdge() && self.viewModel.shouldLoadNextPage ?
                    self.viewModel.listUpcomingMovies().startWith(.loading) : Observable.empty()
        }
        
        let firstLoadingObservable = viewModel.listUpcomingMovies().observeOn(MainScheduler.instance).startWith(.firstLoading)
        
        let viewState = Observable.merge(firstLoadingObservable, noConnectionRetryObservable, contentOffsetObservable)
            .share()
        
        viewState
            .subscribe(onNext: { [unowned self] state in self.render(state) })
            .disposed(by: self.bag)
    }
    
    private func render(_ state: UpcomingMoviesState) {
        switch state {
        case let .succcess(upcomingMovies):
            hideLoading()
            upcomingMoviesSubject.onNext(upcomingMovies)
            
        case let .error(state):
            hideLoading()
            render(state)
        case .firstLoading: showFirstLoading()
        case .loading: showLoading()
        }
    }
    
    private func render(_ state: UpcomingMoviesErrorState) {
        switch state {
        case .general: showErrorView()
        case .network: showNoConnectionView()
        }
    }
}
// MARK: - State views

extension UpcomingMoviesTableViewController {
    private func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    private func showFirstLoading() {
        add(child: loadingView, with: navigationController?.view.frame)
        loadingView.show()
    }
    
    private func hideLoading() {
        loadingView.hide()
        loadingIndicator.stopAnimating()
    }
    
    private func showErrorView() {
        add(child: errorView, with: navigationController?.view.frame)
        errorView.show()
    }
    
    private func hideErrorView() {
        errorView.hide()
    }
    
    private func showNoConnectionView() {
        add(child: noConnectionView, with: navigationController?.view.frame)
        noConnectionView.show()
    }
    
    private func hideNoConnectionView() {
        noConnectionView.hide()
    }
}
