//
//  RaceListCoordinator.swift
//  horse-racer
//

import UIKit

final class RaceListCoordinator: Coordinator {
    
    // MARK: Properties
    
    var networkService = RaceListNetworkService()
    let url = URL(string: "https://www.google.com")!
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var viewModel: [Race] = [] {
        didSet {
            print("viewModel set!")
        }
    }
    
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
     let viewController = RaceListViewController()
    
    
    // MARK: Coordinator Logic
    
    func start() {
        
        viewController.coordinator = self
        viewController.title = "Live Races"
        
        viewController.tableView.register(RaceCell.self, forCellReuseIdentifier: RaceCell.reuseIdentifier)
        
        navigationController.pushViewController(viewController, animated: true)
        
        fetch()
    }
    
    func showRace(_ race: Race) {
        
        // Setup child RaceCoordinator here...
        print("attempting to show race: \(race.name)")
        
    }
    
    
    // MARK: Networking
    
    func fetch() {
        
        viewController.state = .loading
        
        networkService.fetch(url: url) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.viewController.state = .success(model)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.viewController.state = .error
                }
            }
        }
        
    }
    
}
