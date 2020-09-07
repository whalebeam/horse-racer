//
//  MainCoordinator.swift
//  horse-racer
//

import UIKit

final class MainCoordinator: NSObject, Coordinator {
    
    // MARK: Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: Coordinator Logic
    
    func start() {
        navigationController.delegate = self
        // Could have future cases where we want to show onboarding
        // but for now show the races coordinator.
        showRaces()
    }
    
    func showRaces() {
        
        let child = RaceListCoordinator(navigationController: navigationController, raceListViewController: RaceListViewController())
        childCoordinators.append(child)
        child.start()
        
    }
    
    func childFinished(coordinator: Coordinator?) {
        if let coordinator = coordinator {
            navigationController.delegate = self
            remove(child: coordinator)
        }
    }
    
}

extension MainCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        guard navigationController.viewControllers.contains(fromViewController) == false else { return }

        if let viewController = fromViewController as? RaceListViewController {
            childFinished(coordinator: viewController.coordinator)
        }
    }
    
}
