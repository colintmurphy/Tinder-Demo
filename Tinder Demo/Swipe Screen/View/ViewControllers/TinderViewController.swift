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
        cardsView.viewModel?.initContainerViewCards(with: users)
    }
    
    func addConnection(user: User) {
        
        if let connectsVC = UIStoryboard
            .init(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ConnectsViewController") as? ConnectsViewController {
            
            if let model = connectsVC.viewModel {
                model.addConnect(user: user)
            } else {
                connectsVC.viewDidLoad()
                let model = ConnectsViewModel(delegate: connectsVC)
                model.addConnect(user: user)
            }
            //connectsVC.viewModel?.addConnect(user: user)
        }
        //print("user: ", user)
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
