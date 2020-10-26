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
    
    func addCardToContainer(card: CardView, at index: Int) {
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
