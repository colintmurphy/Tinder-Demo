//
//  SwipeableView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

protocol SwipeableViewDelegate: AnyObject {

    func didTap(_ view: SwipeableView)
    func didBeginSwipe(on view: SwipeableView)
    func didEndSwipe(on view: SwipeableView)
}

class SwipeableView: UIView {

    weak var delegate: SwipeableViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupGestureRecognizers()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupGestureRecognizers()
    }
}
