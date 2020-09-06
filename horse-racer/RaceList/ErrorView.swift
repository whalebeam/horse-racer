//
//  ErrorView.swift
//  horse-racer
//

import UIKit

final class ErrorView: UIView {
    
    private struct ErrorViewConstants {
        static let errorLabelText = "Something went wrong while loading races."
        static let retryButtonAccessibilityHint = "Try to fetch the data again."
    }

    // MARK: Properties
    
    private lazy var errorLabel: UILabel = {
       
        let label = UILabel()
        
        label.text = ErrorViewConstants.errorLabelText
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var retryButton: UIButton = {

        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("Retry", for: .normal)
        button.layer.cornerRadius = 10

        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        button.contentEdgeInsets = .init(top: 12, left: 0, bottom: 12, right: 0)
        
        button.accessibilityHint = ErrorViewConstants.retryButtonAccessibilityHint

        return button
    }()
    
    private lazy var stackView: UIStackView = {
      
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(retryButton)
        
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .center
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.addArrangedSubview(stackView)
        
        return container

    }()
    
    var retryButtonAction: (() -> Void)?
    
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(containerStackView)
        
        containerStackView.pin(to: self, padding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Helper
    
    @objc
    func retryButtonTapped() {
        retryButtonAction?()
    }

}
