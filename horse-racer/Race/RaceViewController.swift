//
//  RaceViewController.swift
//  horse-racer
//

import UIKit

enum Section: CaseIterable {
    case race
}

class RaceViewController: UIViewController {
    
    private struct RaceConstants {
        static let reuseIdentifier = "HorseCell"
    }
    
    // MARK: Properties
    
    var viewModel: Race
    
    var tableView = UITableView()
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Horse>
    
    var dataSource: DataSource!
    
    
    let segmentControl = UISegmentedControl()
    
    
    // MARK: Init
    
    init(viewModel: Race) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor.systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(segmentControl)
        
        configureTableView()
        configureSegmentControl()
        configureLayout()
        
        
        // Data source work
        configureDataSource()
        updateDataSource(animated: true, sortBy: .cloth)
    }
    
    
    // MARK: Helpers
    
    enum SortingCategory: Int {
        case cloth
        case odds
        case form
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
        
            segmentControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            
        ])
        
    }
    
    private func configureSegmentControl() {
        segmentControl.insertSegment(withTitle: "Cloth", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Odds", at: 1, animated: false)
        segmentControl.insertSegment(withTitle: "Form", at: 2, animated: false)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = dataSource
        tableView.register(HorseCell.self, forCellReuseIdentifier: RaceConstants.reuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    private func updateDataSource(animated: Bool, sortBy category: SortingCategory = .cloth) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Horse>()
        
        var sortedHorses: [Horse] = []
        
        switch category {
        case .cloth:
            print("cloth")
            
            sortedHorses = viewModel.rides.sorted { $0.clothNumber < $1.clothNumber }.map { $0.horse }
            
        case .odds:
            print("odds")
            
            sortedHorses = viewModel.rides.sorted { $0.currentOdds < $1.currentOdds }.map { $0.horse }
            
        case .form:
            print("form")
            sortedHorses = viewModel.rides.sorted { $0.formSummary < $1.formSummary }.map { $0.horse }
        }
        
        
        
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(sortedHorses, toSection: .race)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
        
        
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Horse>(tableView: tableView) { tableView, indexPath, horse -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RaceConstants.reuseIdentifier, for: indexPath)
            
            cell.textLabel?.text = horse.name
            
            return cell
            
        }
    }
    
    
    // MARK: Obj-c Methods
    
    @objc
    func segmentValueChanged() {
        let category = SortingCategory.init(rawValue: segmentControl.selectedSegmentIndex) ?? .cloth
        updateDataSource(animated: true, sortBy: category)
    }
    
}
