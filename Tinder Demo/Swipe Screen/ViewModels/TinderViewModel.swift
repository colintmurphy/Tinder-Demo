//
//  TinderViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

protocol TinderViewModelDelegate: AnyObject {
    func failed(error: TinderError)
    func addConnection(user: User)
    func addCardToContainer(card: CardView, at index: Int)
}

class TinderViewModel {
    
    // MARK: - Properties
    
    private let horizontalInset: CGFloat = 12.0
    private let verticalInset: CGFloat = 12.0
    private let numberOfVisibleCards: Int = 3
    private let containerViewBounds: CGRect
    
    private var users: [User] = []
    private var cardViews: [CardView] = []
    private var usersInContainer: [User] = []
    
    weak var viewModelDelegate: TinderViewModelDelegate?
    
    // MARK: - Inits

    required init(viewModelDelegate: TinderViewModelDelegate, containerViewBounds: CGRect) {
        self.viewModelDelegate = viewModelDelegate
        self.containerViewBounds = containerViewBounds
        loadUsers()
    }
    
    // MARK: - Model Methods
    
    func initContainerViewCards(with users: [User]) {
        
        self.users = users
        for _ in 0..<numberOfVisibleCards {
            insertNewCard()
        }
    }
    
    // MARK: - Private Methods
    
    private func loadUsers() {
        
        NetworkManager.shared.fetchUsers(RandomUserResponse.self) { result in
            switch result {
            case .success(let response):
                if let users = response.results {
                    self.users = users
                    self.initContainerViewCards(with: users)
                } else {
                    self.viewModelDelegate?.failed(error: TinderError.noUsersFound)
                }
            case .failure(let error):
                self.viewModelDelegate?.failed(error: error)
            }
        }
    }
    
    private func insertNewCard() {
        
        guard !users.isEmpty else { return }
        let user = users.removeLast()
        if let card = createUserCardView(with: user) {
            viewModelDelegate?.addCardToContainer(card: card, at: 0)
        }
        updateFrames()
    }
    
    private func createUserCardView(with user: User) -> CardView? {
        
        guard let imageUrl = user.picture?.large else { return nil }
        let card = CardView()
        card.setInfo(name: user.fullName, location: user.fullLocation, age: user.age, imageUrl: imageUrl)
        card.delegate = self
        cardViews.append(card)
        usersInContainer.append(user)
        return card
    }
    
    private func setFrame(for cardView: CardView, at index: Int) -> CardView? {
        
        var cardViewFrame = containerViewBounds
        let verticalInset = CGFloat(index) * self.verticalInset
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        
        cardViewFrame.origin.y += verticalInset
        cardViewFrame.origin.x += (horizontalInset - self.horizontalInset)
        cardViewFrame.size.width -= 2 * horizontalInset
        cardView.frame = cardViewFrame
        return cardView
    }
    
    private func updateFrames() {
        
        for (index, card) in cardViews.enumerated() {
            if let card = setFrame(for: card, at: index) {
                cardViews[index] = card
            }
        }
    }
}

// MARK: - SwipeableViewDelegate

extension TinderViewModel: SwipeableViewDelegate {
    
    func didSwipeLeft(on view: SwipeableView) {
        
        cardViews.removeFirst()
        usersInContainer.removeFirst()
        insertNewCard()
    }
    
    func didSwipeRight(on view: SwipeableView) {
        
        cardViews.removeFirst()
        let user = usersInContainer.removeFirst()
        viewModelDelegate?.addConnection(user: user)
        insertNewCard()
    }
}
