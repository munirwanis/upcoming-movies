//
//  Coordinator.swift
//  UpcomingMovies
//
//  Created by Munir Wanis on 2018-11-26.
//  Copyright © 2018 Wanis Co. All rights reserved.
//

import UIKit

enum AppEventError: Error {
    case eventNotHandled(AppEvent)
}

internal class Coordinator: NSObject, Coordinatable {
    
    var parent: Coordinatable?
    
    var childCoordinators: [String : Coordinatable] = [:]
    
    typealias CoordinatableType = Coordinator
    
    private(set) var handlers: [String: (AppEvent) -> Void] = [:]
    
    weak var rootViewController: UIViewController?
    
    internal init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    open func start(with completion: @escaping () -> Void = {}) {
        self.rootViewController?.parentCoordinator = self
        completion()
    }
    
    open func stop(with completion: @escaping () -> Void = {}) {
        self.rootViewController?.parentCoordinator = nil
        completion()
    }
    
    open func startChild(coordinator: Coordinatable, completion: @escaping () -> Void = {}) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.parent = self
        coordinator.start(with: completion)
    }
    
    internal func stopChild(coordinator: Coordinatable, completion: @escaping () -> Void = {}) {
        coordinator.parent = nil
        coordinator.stop { [unowned self] in
            self.childCoordinators.removeValue(forKey: coordinator.identifier)
            completion()
        }
    }
    internal final func add<T>(eventType: T.Type, handler: @escaping (T) -> Void) where T : AppEvent {
        handlers[String(reflecting: eventType)] = { ev in
            guard let realEV = ev as? T else { return }
            handler(realEV)
        }
    }
    
    internal final func handle<T: AppEvent>(event: T) throws {
        let target = self.target(forEvent: event)
        guard let handler = target?.handlers[String(reflecting: type(of: event))] else {
            throw AppEventError.eventNotHandled(event)
        }
        handler(event)
    }
    
    internal final func canHandle<T: AppEvent>(event: T) -> Bool {
        return handlers[String(reflecting: type(of: event))] != nil
    }
    
    internal func target<T: AppEvent>(forEvent event: T) -> Coordinatable? {
        guard self.canHandle(event: event) != true else { return self }
        var next = self.parent
        while next?.canHandle(event: event) == false {
            next = next?.parent
        }
        return next
    }
    
}
