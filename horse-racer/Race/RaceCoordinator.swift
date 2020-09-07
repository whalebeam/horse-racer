//
//  RaceCoordinator.swift
//  horse-racer
//

import UIKit


final class RaceCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators = [Coordinator]()
    
    var parentCoordinator: RaceListCoordinator?
    
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
        
        let webCoordinator = WebCoordinator(navigationController: navigationController, url: raceURL)
        
        childCoordinators.append(webCoordinator)
        
        webCoordinator.start()
    }
    
    func didFinish() {
        parentCoordinator?.childFinished(coordinator: self)
    }
    
    func childFinished(coordinator: Coordinator?) {
        if let coordinator = coordinator {
            remove(child: coordinator)
        }
    }
    
}

