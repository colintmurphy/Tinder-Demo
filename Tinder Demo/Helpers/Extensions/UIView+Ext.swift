//
//  UIView+Ext.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

extension UIView {
    
    func addShadow(to view: UIView, with margin: CGFloat) -> UIView {
        
        let frame = CGRect(x: 0, y: 0,
                           width: view.bounds.width - (2 * margin),
                           height: view.bounds.height - (2 * margin))
        let shadowView = UIView(frame: frame)
        let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = 8.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(0.0))
        shadowView.layer.shadowOpacity = 0.15
        shadowView.layer.shadowPath = shadowPath.cgPath
        insertSubview(shadowView, at: 0)
        return shadowView
    }
}
