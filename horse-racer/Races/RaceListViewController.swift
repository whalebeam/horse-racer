//
//  RaceListViewController.swift
//  horse-racer
//

import UIKit

class RaceListViewController: UIViewController {
    
    enum State {
        case initialised
        case loading
        case success ([Race])
        case error
    }
    
    // MARK: Properties
    
    weak var coordinator: RaceListCoordinator?
    
    var state: State = .initialised {
        didSet {
            configureView(state: state)
        }
    }
    
    var dataSource = RaceListDataSource() {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    
    let tableView: UITableView = .init()
    
    var errorView: UIView = {
       
        let v = UIView()
        let l = UILabel()
        
        l.text = "Oops! Something went wrong."
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        
        v.addSubview(l)
        v.backgroundColor = .red
        
        l.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        
        return v
    }()
    
    var loadingView: UIActivityIndicatorView = {
        
        let a = UIActivityIndicatorView(style: .large)
        a.color = .gray
        a.translatesAutoresizingMaskIntoConstraints = false
        a.startAnimating()
        
        return a
    }()
    

    // MARK: View Lifecycle
    
    override func loadView() {
        view = UIView()
        view.addSubview(tableView)
        view.addSubview(loadingView)
        loadingView.center(in: view)
        
        configureTableView()
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
        
        print("Race List VC Loaded! 😺")
    }
    
    
    // MARK: Helpers
    
    private func configureView(state: State) {
        
        loadingView.isHidden = true
        
        switch state {
        case .initialised:
            print("Inititalised. Lift off! 🚀")
        case .success (let model):
            dataSource.model = model
            tableView.reloadData()
            print("Successfully loaded data! ✅")
        case .loading:
            print("Loading data, please wait... ⏳")
            loadingView.isHidden = false
        case .error:
            print("Oops, something went wrong. 💥")
            view.addSubview(errorView)
            errorView.pin(to: view)
        }
        
    }
    
    private func configureTableView() {
        tableView.pin(to: view)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }
    
}


// MARK: - UITableViewDelegate

extension RaceListViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let race = dataSource.getRace(at: indexPath.row)
        coordinator?.showRace(race)
    }
    
}
