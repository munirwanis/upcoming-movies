//
//  AppCoordinator.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

internal class AppCoordinator: Coordinator {
    private var window: UIWindow
    private var navigationController: UINavigationController?
    
    override func start(with completion: @escaping () -> Void = {}) {
        let mapper = UpcomingMoviesMapper()
        let genresDatabase = GenresDatabase()
        let upcomingMoviesServiceMapper = UpcomingMoviesServiceMapper(database: genresDatabase)
        let upcomingMoviesService = UpcomingMoviesService(mapper: upcomingMoviesServiceMapper)
        let imageService = ImageDownloadService()
        let viewModel = UpcomingMoviesViewModel(mapper: mapper, service: upcomingMoviesService, imageService: imageService)
        let controller = UpcomingMoviesTableViewController(viewModel: viewModel)
        controller.parentCoordinator = self
        
        navigationController?.viewControllers = [controller]
        
        window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
        add(eventType: MovieModel.self, handler: eventHandler)
    }
    
    private func eventHandler(_ event: MovieModel) {
        let controller = MovieTableViewController(movie: event)
        controller.parentCoordinator = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    init(window: UIWindow) {
        self.window = window
        
        navigationController = UINavigationController()
        super.init(rootViewController: navigationController)
    }
}
