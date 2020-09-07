//
//  WebCoordinator.swift
//  horse-racer
//

import UIKit

final class WebCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let viewController: WebViewController
    
    
    // MARK: Init
    
    init(navigationController: UINavigationController, url: URL) {
        self.navigationController = navigationController
        self.viewController = WebViewController(url: url)
    }
    
    
    // MARK: Coordinator Logic
    
    func start() {
        viewController.title = "Sky Bet Horse Racing"
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
