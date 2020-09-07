//
//  Coordinator.swift
//  horse-racer
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
    
    func childFinished(coordinator: Coordinator?)
}

extension Coordinator {
    
    func remove(child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
