//
//  RaceCoordinator.swift
//  horse-racer
//

import UIKit


final class RaceCoordinator: Coordinator {
    
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    
    var viewModel: Race
    
    init(navigationController: UINavigationController, race: Race) {
        self.navigationController = navigationController
        self.viewModel = race
    }
    
    func start() {
        
        
        
    }
    
}
