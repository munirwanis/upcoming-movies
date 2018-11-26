//
//  UIViewController+ChildViewController.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-20.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

protocol ChildViewControllable {}

extension ChildViewControllable where Self: UIViewController {
    func add(child viewController: UIViewController, with frame: CGRect? = nil) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = frame ?? CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        viewController.didMove(toParent: self)
    }

    func removeChild() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIViewController: ChildViewControllable {}
