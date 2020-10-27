//
//  TinderViewController.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class TinderViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cardsView: CardsContainerView!
    
    // MARK: - Properties

    var viewModel: TinderViewModel?
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TinderViewModel(viewModelDelegate: self, containerViewBounds: cardsView.bounds)
    }
}

// MARK: - TinderViewModelDelegate

extension TinderViewController: TinderViewModelDelegate {
    
    func addCardToContainer(card: NewCardView, at index: Int) {
        
        var cardViewFrame = cardsView.bounds
        let verticalInset = CGFloat(index) * CGFloat(14)
        let horizontalInset = (CGFloat(index) * CGFloat(14))
        
        cardViewFrame.origin.y += verticalInset
        cardViewFrame.origin.x += horizontalInset //(horizontalInset - CGFloat(14))
        cardViewFrame.size.width -= 2 * horizontalInset
        card.frame = cardViewFrame
        
        cardsView.insertSubview(card, at: index)
    }
    
    func failed(error: TinderError) {
        
        switch error {
        case .badImageUrl, .couldNotDownloadImage, .couldNotUnwrapImage:
            break
            
        case .failedFetchingData:
            break
            
        case .noUsersFound:
            break
        }
    }
}
