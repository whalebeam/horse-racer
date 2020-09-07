//
//  HorseCell.swift
//  horse-racer
//

import UIKit

final class HorseCell: UITableViewCell {

    
    // MARK: Properties
    
    let nameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)

        return label

    }()

    let lastRunLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)

        return label

    }()
    
    let oddsLabel: UILabel = {
        
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.numberOfLines = 0
       label.font = UIFont.preferredFont(forTextStyle: .subheadline)

       return label
    }()
    
    var horse: Horse? {
        didSet {
            if let horse = horse, let cloth = clothNumber {
                nameLabel.text = "🐎 \(horse.name) (\(cloth))"
            }
        }
    }
    
    var clothNumber: Int?
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let horseInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        horseInfoStackView.addArrangedSubview(nameLabel)
        horseInfoStackView.addArrangedSubview(lastRunLabel)
        horseInfoStackView.addArrangedSubview(oddsLabel)
        
        contentView.addSubview(containerView)
        containerView.addSubview(horseInfoStackView)

        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    func configureConstraints() {
        
        horseInfoStackView.pin(to: containerView)
        
        containerView.pin(to: contentView, padding: 20)
        
    }

}
