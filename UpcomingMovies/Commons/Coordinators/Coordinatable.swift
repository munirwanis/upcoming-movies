//
//  Coordinatable.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import Foundation

protocol Coordinatable: AnyObject, NSObjectProtocol {
    
    var parent: Coordinatable? { get set }
    
    var identifier: String { get }
    
    var handlers: [String: (AppEvent) -> Void] { get }
    
    func target<T: AppEvent>(forEvent event: T) -> Coordinatable?
    func handle<T: AppEvent>(event: T) throws
    func add<T: AppEvent>(eventType: T.Type, handler: @escaping (T) -> Void)
    func canHandle<T: AppEvent>(event: T) -> Bool
    
    func start(with completion: @escaping () -> Void)
    func stop(with completion: @escaping () -> Void)
    
    var childCoordinators: [String: Coordinatable] { get }
    
    func startChild(coordinator: Coordinatable, completion: @escaping () -> Void)
    func stopChild(coordinator: Coordinatable, completion: @escaping () -> Void)
    
}

extension Coordinatable {
    
    var identifier: String {
        return "\(String(describing: type(of: self)))-\(self.hash)"
    }
    
}
