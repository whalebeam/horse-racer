//
//  UIView+Extension.swift
//  horse-racer
//

import UIKit

extension UIView {
    func pin(to view: UIView, padding: CGFloat = 0) {
        NSLayoutConstraint.activate([
        
            self.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: padding),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    
    func center(in view: UIView) {
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
