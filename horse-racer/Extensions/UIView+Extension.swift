//
//  UIView+Extension.swift
//  horse-racer
//

import UIKit

extension UIView {
    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
        
            self.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
