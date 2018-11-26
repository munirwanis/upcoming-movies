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

final class MovieTableViewController: UITableViewController {
    init() {
        super.init(nibName: MovieTableViewController.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = #imageLiteral(resourceName: "internalErrorIcon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
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
        roundIcon.image = image
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 30
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
        return UITableViewCell()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
