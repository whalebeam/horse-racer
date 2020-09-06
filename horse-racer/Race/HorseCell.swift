//
//  HorseCell.swift
//  horse-racer
//
//  Created by David Gray on 06/09/2020.
//  Copyright © 2020 whalebeam. All rights reserved.
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
    
//    var oddsView: UIView = {
//
//        let oddsView = UIView()
//        oddsView.translatesAutoresizingMaskIntoConstraints = false
//        oddsView.backgroundColor = .systemGray6
//        oddsView.clipsToBounds = true
//        oddsView.layer.cornerRadius = 8
//
//        let oddsLabel = UILabel()
//        oddsLabel.translatesAutoresizingMaskIntoConstraints = false
//        oddsLabel.text = "5/2"
//
//
//        oddsView.addSubview(oddsLabel)
//
//
//        oddsLabel.pin(to: oddsView, padding: 20)
//
//        return oddsView
//
//    }()
    
    var horse: Horse? {
        didSet { nameLabel.text = horse?.name }
    }
    
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
//        horseInfoStackView.addArrangedSubview(oddsView)

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
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
    }

}



