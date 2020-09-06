//
//  RaceCell.swift
//  horse-racer
//

import UIKit

final class RaceCell: UITableViewCell {
    
    // MARK: Properties

    static let reuseIdentifier = "RaceCell"
    
    var nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        l.adjustsFontForContentSizeCategory = true
        
        return l
    }()
    
    var courseLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.adjustsFontForContentSizeCategory = true
        
        return l
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, padding: 20)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(courseLabel)
        
        contentView.backgroundColor = UIColor(named: "race_list_cell_background_color")
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
}
