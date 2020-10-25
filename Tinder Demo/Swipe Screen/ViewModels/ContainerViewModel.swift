//
//  ContainerViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

protocol ContainerViewModelProtocol {
    func addCardView(_ cardView: CardView, at index: Int)
}

class ContainerViewModel {
    
    // MARK: - Properties
    
    private let horizontalInset: CGFloat = 12.0
    private let verticalInset: CGFloat = 12.0
    private let numberOfVisibleCards: Int = 3
    
    weak var delegate: TinderViewModel?
    weak var containerView: CardsContainerView?
    
    private var cardViews: [CardView] = []
    var users: [User] = []
    
    // MARK: - Inits
    
    required init(_ view: CardsContainerView) {
        containerView = view
    }
    
    // MARK: - Methods
    
    func addCards(with users: [User]) {
        
        self.users = users
        for _ in 0..<3 {
            insertNewCard()
        }
    }
    
    func insertNewCard() {
        
        guard !users.isEmpty else { return }
        let user = users.removeLast()
        if let card = createUserCardView(with: user) {
            containerView?.addCardView(card, at: cardViews.count-1)
        }
        updateFrames()
    }
    
    private func createUserCardView(with user: User) -> CardView? {
        
        guard let imageUrl = user.picture?.large else { return nil }
        let card = CardView()
        card.user = user
        card.setInfo(name: user.fullName, location: user.fullLocation, age: user.age, imageUrl: imageUrl)
        return card
    }
    
    func addCardView(_ cardView: CardView, at index: Int) -> CardView? {
        
        guard let card = setFrame(for: cardView, at: index) else { return nil }
        card.delegate = self
        cardViews.append(card)
        return card
    }
    
    private func setFrame(for cardView: CardView, at index: Int) -> CardView? {
        
        guard let bounds = containerView?.bounds else { return nil }
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        cardView.frame = cardViewFrame
        return cardView
    }
    
    func updateFrames() {
        
        for (index, card) in cardViews.enumerated() {
            if let card =  setFrame(for: card, at: index) {
                cardViews[index] = card
            }
        }
    }
}

// MARK: - SwipeableViewDelegate

extension ContainerViewModel: SwipeableViewDelegate {
    
    func didSwipeLeft(on view: SwipeableView) {
        
        cardViews.removeFirst()
        insertNewCard()
    }
    
    func didSwipeRight(on view: SwipeableView) {
        
        let card = cardViews.removeFirst()
        //containerView?.addConnection(user: card.user)
        //delegate?.addConnect(user: card.user)
        delegate?.delegate?.addConnection(user: card.user)
        insertNewCard()
    }
}
