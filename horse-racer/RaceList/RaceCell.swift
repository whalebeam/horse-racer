//
//  RaceCell.swift
//  horse-racer
//

import UIKit

final class RaceCell: UITableViewCell {
    
    private struct RaceCellConstants {
        static let cellCornerRadius: CGFloat = 10
        static let cellBackgroundColorName = "race_list_cell_background"
        static let cellStackViewPadding: CGFloat = 15
    }
    
    // MARK: Properties

    static let reuseIdentifier = "RaceCell"
    
    lazy var nameLabel: UILabel = {
        return createLabel(font: UIFont.preferredFont(forTextStyle: .title2))
    }()
    
    lazy var courseLabel: UILabel = {
        return createLabel(font: UIFont.preferredFont(forTextStyle: .headline))
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        containerView.addSubview(stackView)
        stackView.pin(to: containerView, padding: RaceCellConstants.cellStackViewPadding)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(courseLabel)
        
        contentView.addSubview(containerView)
        
        configureConstraints()
        
        containerView.backgroundColor = UIColor(named: RaceCellConstants.cellBackgroundColorName)
        
        containerView.layer.cornerRadius = RaceCellConstants.cellCornerRadius
        containerView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Helper
    
    private func createLabel(font: UIFont) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = font
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
}
