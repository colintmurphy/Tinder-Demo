//
//  SwipeableView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit
import CoreGraphics

//swiftlint:disable trailing_whitespace

protocol SwipeableViewDelegate: AnyObject {
    func didSwipeLeft(on view: SwipeableView)
    func didSwipeRight(on view: SwipeableView)
}

class SwipeableView: UIView {
    
    private var initialCenter = CGPoint()

    weak var delegate: SwipeableViewDelegate?
    
    // MARK: Gesture Recognizer

    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var panGestureTranslation: CGPoint = .zero

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }
    
    deinit {
        if let panGestureRecognizer = panGestureRecognizer {
            removeGestureRecognizer(panGestureRecognizer)
        }
    }
    
    private func setupGestureRecognizers() {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.panGestureRecognizer = panGestureRecognizer
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func panGestureRecognized(_ sender: UIPanGestureRecognizer) {
        
        guard let card = sender.view else { return }
        let translation = sender.translation(in: card.superview)
        
        switch sender.state {
        case .began:
            initialCenter = card.center
            
        case .changed:
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            card.center = newCenter
            
        case .ended:
            checkSwipeState(of: card)
            
        case .cancelled, .failed, .possible:
            break
            
        @unknown default:
            break
        }
    }
    
    private func checkSwipeState(of card: UIView) {
        
        var move: CGPoint!
        if card.center.x > initialCenter.x + 75 {
            move = CGPoint(x: self.initialCenter.x + 500,
                           y: self.initialCenter.y)
            delegate?.didSwipeRight(on: self)
        } else if card.center.x < initialCenter.x - 75 {
            move = CGPoint(x: self.initialCenter.x - 500,
                           y: self.initialCenter.y)
            delegate?.didSwipeLeft(on: self)
        } else {
            move = initialCenter
        }
        
        UIView.animate(withDuration: 0.2) {
            card.center = move
        }
    }
}
