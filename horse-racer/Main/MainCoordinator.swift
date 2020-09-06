//
//  MainCoordinator.swift
//  horse-racer
//

import UIKit

final class MainCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: Coordinator Logic
    
    func start() {
//        let viewController = MainViewController()
//        viewController.coordinator = self
//
//        navigationController.pushViewController(viewController, animated: false)
        
        showRaces()
        
        // TODO?: Logic to determine Main coord, e.g. Show onboarding / racing?
    }
    
    func showRaces() {
        
        let child = RaceListCoordinator(navigationController: navigationController, raceListViewController: RaceListViewController())
        childCoordinators.append(child)
        child.start()
        
    }
    
}
