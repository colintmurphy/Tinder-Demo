//
//  Nib+Ext.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

protocol NibView where Self: UIView { }

extension NibView {

    func setupXib() {
        backgroundColor = .clear
        if let view = loadViewFromNib() {
            addSubviewWithEdgeConstraints(view)
        }
    }

    private func loadViewFromNib() -> CardView? {
        return Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? CardView
    }
}
