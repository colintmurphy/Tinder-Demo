//
//  SwipeViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/23/20.
//

import Foundation

//swiftlint:disable trailing_whitespace

protocol TinderViewModelDelegate: AnyObject {
    func addConnection(user: User)
    func failed(error: TinderError)
    func addUsersToCards(users: [User])
}

class TinderViewModel {
    
    // MARK: - Properties

    weak var view: TinderViewController?
    private var connects: [User] = []
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
    
    // MARK: - Methods
    
    private func loadUsers() {
        
        NetworkManager.shared.fetchUsers(RandomUserResponse.self) { result in
            switch result {
            case .success(let response):
                if let users = response.results {
                    self.dataSource = users
                } else {
                    self.view?.failed(error: TinderError.noUsersFound)
                }
            case .failure(let error):
                self.view?.failed(error: error)
            }
        }
    }
    
    func addConnect(user: User) {
        connects.append(user)
        print(connects)
    }
}
