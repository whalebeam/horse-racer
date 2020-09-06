//
//  RaceCoordinator.swift
//  horse-racer
//

import UIKit


final class RaceCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    lazy var viewController: RaceViewController = {
        return RaceViewController(viewModel: viewModel)
    }()
    
    let viewModel: Race
    
    
    // MARK: Init
    
    init(navigationController: UINavigationController, race: Race) {
        self.navigationController = navigationController
        self.viewModel = race
    }
    
    
    // MARK: Coordinator Logic
    
    func start() {
        viewController.title = viewModel.name
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func showWebPage(raceURL: URL) {
        // TODO: Show Web page
    }
    
}