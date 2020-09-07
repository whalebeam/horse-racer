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
        static let tableViewRowHeight: CGFloat = 120
    }
    
    // MARK: Properties
    
    private let viewModel: Race
    
    var tableView = UITableView()
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Ride>
    
    var dataSource: DataSource!
    
    weak var coordinator: RaceCoordinator?
    
    private let segmentControl = UISegmentedControl()
    
    private var sortByLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.text = "Sort by:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    
    // MARK: Init
    
    init(viewModel: Race) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        coordinator?.didFinish()
    }
    
    
    // MARK: View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor.systemBackground
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sortByLabel)
        view.addSubview(segmentControl)
        view.addSubview(tableView)
        
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
            
            sortByLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            sortByLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sortByLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            
            segmentControl.topAnchor.constraint(equalTo: sortByLabel.bottomAnchor, constant: 20),
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = RaceConstants.tableViewRowHeight
        tableView.delegate = self
    }
    
    private func updateDataSource(animated: Bool, sortBy category: SortingCategory = .cloth) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Ride>()
        
        var sortedRides: [Ride] = []
        
        switch category {
        case .cloth:
            sortedRides = viewModel.rides.sorted { $0.clothNumber < $1.clothNumber }
        case .odds:
            sortedRides = viewModel.rides.sorted { $0.currentOdds.value > $1.currentOdds.value }
        case .form:
            // TODO: in the future make this sort properly
            sortedRides = viewModel.rides.sorted { $0.formSummary < $1.formSummary }
        }

        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(sortedRides, toSection: .race)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
        
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Ride>(tableView: tableView) { tableView, indexPath, ride in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RaceConstants.reuseIdentifier, for: indexPath) as? HorseCell else {
                return UITableViewCell()
            }
            
            cell.clothNumber = ride.clothNumber
            cell.horse = ride.horse
            cell.lastRunLabel.text = "Last ran: \(ride.horse.daysSinceLastRun) days ago"
            cell.oddsLabel.text = "Current odds: \(ride.currentOdds.text)"
            
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

// MARK: UITableViewDelegate

extension RaceViewController: UITableViewDelegate {
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snapshot = dataSource.snapshot()
        
        let items = dataSource.snapshot().itemIdentifiers(inSection: snapshot.sectionIdentifiers[indexPath.section])
        
        
        let ride = items[indexPath.row]
        
        if let url = URL(string: ride.url) {

            coordinator?.showWebPage(raceURL: url)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
 
