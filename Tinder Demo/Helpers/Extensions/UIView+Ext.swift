//
//  UIView+Ext.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

extension UIView {

    func addSubviewWithEdgeConstraints(_ view: UIView) {
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .left, .right]
        
        for attribute in attributes {
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: view,
                                   attribute: attribute,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: attribute,
                                   multiplier: 1.0, constant: 0)
            ])
        }
    }
}
