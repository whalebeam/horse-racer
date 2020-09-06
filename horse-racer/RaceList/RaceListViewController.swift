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
    
    private let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        control.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return control
    }()
    
    lazy var errorView: ErrorView = {
        let errorView = ErrorView(frame: .zero)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.retryButtonAction = refreshData
        
        return errorView
    }()
    
    var loadingView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .gray
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.startAnimating()
        
        return activityView
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
        view.backgroundColor = .systemBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
    }
    
    
    // MARK: Helpers
    
    private func configureView(state: State) {
        
        loadingView.isHidden = true
        removeErrorView()
        
        switch state {
        case .initialised:
            print("🚀 init")
            refreshControl.endRefreshing()
            
        case .success (let model):
            print("✅ success")
            refreshControl.endRefreshing()
            
            dataSource.model = model
            tableView.reloadData()
            
        case .loading:
            print("⏳ loading")
            /* Only show the central loading indicator on the initial launch
               when we have no data, otherwise pull to refresh will indicate
               loading to the user.
             */
            loadingView.isHidden = dataSource.model.isEmpty ? false : true
            
        case .error:
            print("❌ error")
            refreshControl.endRefreshing()
            
            if !view.subviews.contains(errorView) {
                view.addSubview(errorView)
                errorView.pin(to: view)
                errorView.isHidden = false
            }
        }
        
    }
    
    private func configureTableView() {
        tableView.refreshControl = refreshControl
        tableView.pin(to: view)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.backgroundView = refreshControl
    }
    
    private func removeErrorView() {
        if view.subviews.contains(errorView) {
            errorView.removeFromSuperview()
        }
    }
    
    
    // MARK: Objc methods
    
    @objc
    func refreshData() {
//        tableView.backgroundView = refreshControl
        coordinator?.refreshData()
    }
    
}


// MARK: - UITableViewDelegate

extension RaceListViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let race = dataSource.getRace(at: indexPath.row)
        coordinator?.showRace(race)
    }
    
}
