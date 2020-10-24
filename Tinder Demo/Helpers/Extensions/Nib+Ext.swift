//
//  Nib+Ext.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

protocol NibView where Self: UIView { }

extension NibView {

    func setupXib() {
        let view = loadViewFromNib()
        addSubviewWithEdgeConstraints(view)
    }

    private func loadViewFromNib<T: UIView>() -> T {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Couldn't load nib for class \(type(of: self))")
        }
        return view
    }
}
