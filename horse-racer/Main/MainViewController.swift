//
//  MainViewController.swift
//  horse-racer
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: Properties
    
    weak var coordinator: MainCoordinator?
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        print("Main View instantiated. We have liftoff! 🚀")
    }
    
}
