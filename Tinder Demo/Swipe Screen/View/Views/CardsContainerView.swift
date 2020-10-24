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
    
    var viewModel: ContainerViewModel?
    
    // MARK: - Methods

    override func awakeFromNib() {
        
        super.awakeFromNib()
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        viewModel = ContainerViewModel(self)
    }
}

// MARK: - ContainerViewModelProtocol

extension CardsContainerView: ContainerViewModelProtocol {
    
    func addCardView(_ cardView: CardView, at index: Int) {
        guard let card = viewModel?.addCardView(cardView, at: index) else { return }
        insertSubview(card, at: 0)
    }
}
