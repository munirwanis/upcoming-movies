//
//  UpcomingMoviesTableViewController.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-24.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

final class UpcomingMoviesTableViewController: UITableViewController {
    
    init() {
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
}

// MARK: - Table view data source

extension UpcomingMoviesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
}

// MARK: - Setup

extension UpcomingMoviesTableViewController {
    private func setup() {
        
    }
}
