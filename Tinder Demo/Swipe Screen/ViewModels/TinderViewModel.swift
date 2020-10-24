//
//  SwipeViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/23/20.
//

import Foundation

//swiftlint:disable trailing_whitespace

protocol TinderViewModelDelegate: AnyObject {
    func failed(error: TinderError)
    func addUsersToCards(users: [User])
}

class TinderViewModel {
    
    // MARK: - Properties

    weak var view: TinderViewController?
    
    private var dataSource: [User] = [] {
        didSet {
            view?.addUsersToCards(users: dataSource)
        }
    }
    
    // MARK: - Inits

    required init(view: TinderViewController) {
        self.view = view
        loadUsers()
    }
    
    // MARK: - Methopds
    
    private func loadUsers() {
        
        NetworkManager.shared.fetchUsers([User].self) { result in
            switch result {
            case .success(let users):
                self.dataSource = users
            case .failure(let error):
                self.view?.failed(error: error)
            }
        }
    }
}
