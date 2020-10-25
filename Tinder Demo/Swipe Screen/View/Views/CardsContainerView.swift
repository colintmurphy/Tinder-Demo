//
//  CardsContainerView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/23/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class CardsContainerView: UIView {
    
    // MARK: - Properties
    
    let horizontalInset: CGFloat = 12.0
    let verticalInset: CGFloat = 12.0
    var viewModel: ContainerViewModel?

    // MARK: - Methods

    override func awakeFromNib() {
        
        super.awakeFromNib()
        backgroundColor = .systemPink
        translatesAutoresizingMaskIntoConstraints = false
        viewModel = ContainerViewModel(self)
    }
}

// MARK: - ContainerViewModelProtocol

extension CardsContainerView: ContainerViewModelProtocol {
    
    func addCardView(_ cardView: CardView, at index: Int) {
        
        guard let card = viewModel?.addCardView(cardView, at: index) else { return }
        insertSubview(card, at: 0)
        setNeedsLayout()
    }
    
    func addConnection(user: User) {
        print(user)
    }
}
