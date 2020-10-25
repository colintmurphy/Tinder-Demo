//
//  SwipeableCardView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

protocol SwipeableCardViewDelegate: AnyObject {
    func didSelect(card: SwipeableCardView, atIndex index: Int)
}

protocol SwipeableCardViewDataSource: AnyObject {
    func numberOfCards() -> Int
    func cards(with users: [User])
    func card(at index: Int) -> SwipeableCardView
    func emptyCardsView() -> UIView?
}

class SwipeableCardView: SwipeableView, NibView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
