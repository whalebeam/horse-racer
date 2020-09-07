//
//  RaceListCoordinator.swift
//  horse-racer
//

import UIKit

final class RaceListCoordinator: Coordinator {
    
    // MARK: Properties
    
    private let networkService = RaceListNetworkService()
    private let url = URL(string: "https://www.google.com")!
    
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    let viewController: RaceListViewController
    
    private weak var parentCoordinator: MainCoordinator?
    
    var viewModel: [Race] = [] {
        didSet {
            print("viewModel set!")
        }
    }
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, raceListViewController: RaceListViewController) {
        self.navigationController = navigationController
        self.viewController = raceListViewController
    }
    
    
    // MARK: - Coordinator Logic
    
    func start() {
        
        viewController.coordinator = self
        viewController.title = "Live Races"
        
        viewController.tableView.register(RaceListCell.self, forCellReuseIdentifier: RaceListCell.reuseIdentifier)
        
        navigationController.pushViewController(viewController, animated: true)
        
        fetch()
    }
    
    func showRace(_ race: Race) {
        
        let raceCoordintor = RaceCoordinator(navigationController: navigationController, race: race)
        raceCoordintor.parentCoordinator = self
        
        childCoordinators.append(raceCoordintor)
        raceCoordintor.start()
    }
    
    
    // MARK: - Networking
    
    func refreshData() {
        fetch()
    }
    
    private func fetch() {
        
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
    
    // MARK: Coordinator Lifecycle
    
    func didFinish() {
        parentCoordinator?.childFinished(coordinator: self)
    }
    
    func childFinished(coordinator: Coordinator?) {
        if let coordinator = coordinator {
            remove(child: coordinator)
        }
    }
}
