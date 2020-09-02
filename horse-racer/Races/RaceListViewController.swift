//
//  RaceListViewController.swift
//  horse-racer
//

import UIKit


final class RaceListViewController: UIViewController {
    
    // MARK: Properties
    
    weak var coordinator: RaceListCoordinator?
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .systemPink
        
        print("Race List VC Loaded! 😺")
    }
    
}
