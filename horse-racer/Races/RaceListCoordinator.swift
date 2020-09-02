//
//  RaceListCoordinator.swift
//  horse-racer
//

import UIKit

final class RaceListCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: Coordinator Logic
    
    func start() {
        
        let viewController = RaceListViewController()
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
