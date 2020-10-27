//
//  CardsContainerView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/23/20.
//

import UIKit

class CardsContainerView: SwipeableCardView {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemPink
        translatesAutoresizingMaskIntoConstraints = false
    }
}
