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
    
    private var dataSource = RaceListDataSource() {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    
    let tableView = UITableView()
    
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
        super.loadView()
        
        view = UIView()
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.backgroundColor = .systemBackground
        loadingView.center(in: view)
        
        configureTableView()
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
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.backgroundView = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
    }
    
    private func removeErrorView() {
        if view.subviews.contains(errorView) {
            errorView.removeFromSuperview()
        }
    }
    
    
    // MARK: Objc methods
    
    @objc
    func refreshData() {
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
