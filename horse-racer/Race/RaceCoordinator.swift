//
//  RaceCoordinator.swift
//  horse-racer
//

import UIKit


final class RaceCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let viewController: RaceViewController
    
    let viewModel: Race
    
    
    // MARK: Init
    
    init(navigationController: UINavigationController, race: Race) {
        self.navigationController = navigationController
        self.viewModel = race
        self.viewController = RaceViewController(viewModel: race)
    }
    
    
    // MARK: Coordinator Logic
    
    func start() {
        
        viewController.viewModel = viewModel
        viewController.title = viewModel.name
        
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
}
