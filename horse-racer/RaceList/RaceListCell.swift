//
//  RaceCell.swift
//  horse-racer
//

import UIKit

final class RaceListCell: UITableViewCell {
    
    private struct RaceCellConstants {
        static let cellCornerRadius: CGFloat = 10
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
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(courseLabel)
        stackView.pin(to: containerView, padding: RaceCellConstants.cellStackViewPadding)
        
        contentView.addSubview(containerView)
        
        configureConstraints()
        configureContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        configureAccessibility()
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
    
    private func configureContainerView() {
        containerView.backgroundColor = .raceCellBackgroundColor
        containerView.layer.cornerRadius = RaceCellConstants.cellCornerRadius
        containerView.clipsToBounds = true
    }
    
    private func configureAccessibility() {
        
        guard let name = nameLabel.text, let course = courseLabel.text else { return }
        
        isAccessibilityElement = true
        accessibilityLabel = "\(name) race taking place at \(course)"
        accessibilityHint = "Tap to view race details"
        accessibilityTraits = .button
        
    }
    
}
