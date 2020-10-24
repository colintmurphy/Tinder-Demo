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
    
    private var remainingCards: Int = 0
    private var cardViews: [CardView] = []
    
    weak var view: CardsContainerView?
    var dataSource: [CardView] = []
    
    // MARK: - Inits
    
    required init(_ view: CardsContainerView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    func addCards(with users: [User]) {
        
        for user in users {
            if let card = createUserCardView(with: user) {
                dataSource.append(card)
            }
        }
    }
    
    private func createUserCardView(with user: User) -> CardView? {
        
        guard var name = user.name?.first,
              let imageUrl = user.picture?.medium else { return nil }
        
        if let lastName = user.name?.last {
            name += " \(lastName)"
        }
        
        var location: String?
        if let city = user.location?.city,
           let state = user.location?.state {
            location = "\(city), \(state)"
        }
        
        let card = CardView()
        card.setInfo(name: name, location: location, age: user.birth?.age, imageUrl: imageUrl)
        return card
    }
    
    func addCardView(_ cardView: CardView, at index: Int) -> CardView? {
        
        guard let card = setFrame(for: cardView, at: index) else { return nil }
        cardViews.append(card)
        remainingCards -= 1
        return card
    }
    
    private func setFrame(for cardView: CardView, at index: Int) -> CardView? {
        
        guard let bounds = view?.bounds else { return nil }
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        cardView.frame = cardViewFrame
        return cardView
    }
}

// MARK: - SwipeableViewDelegate

extension ContainerViewModel: SwipeableViewDelegate {
    
    func didTap(_ view: SwipeableView) { }
    
    func didBeginSwipe(on view: SwipeableView) { }

    func didEndSwipe(on view: SwipeableView) { }
}

// MARK: - SwipeableViewDataSource

extension ContainerViewModel: SwipeableCardViewDataSource {
    
    func numberOfCards() -> Int { return 0 }
    
    func cards(with users: [User]) { }
    
    func card(at index: Int) -> SwipeableCardView {  return dataSource[index] }
    
    func emptyCardsView() -> UIView? { return nil }
}
