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

    private var viewModel: TinderViewModel?
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Methods

    private func setup() {
        viewModel = TinderViewModel(delegate: self)
        cardsView.viewModel?.delegate = viewModel
    }
}

// MARK: - TinderViewModelDelegate

extension TinderViewController: TinderViewModelDelegate {
    
    func addUsersToCards(users: [User]) {
        cardsView.viewModel?.addCards(with: users)
    }
    
    func addConnection(user: User) {
        print("user: ", user)
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
