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
    func addConnection(user: User)
}

class TinderViewModel {
    
    // MARK: - Properties
    
    weak var delegate: TinderViewModelDelegate?
    //weak var containerDelegate: ?
    
    private var dataSource: [User] = [] {
        didSet {
            delegate?.addUsersToCards(users: dataSource)
            //containerDelegate?.addUsersToCards(users: dataSource)
        }
    }
    
    // MARK: - Inits

    required init(delegate: TinderViewModelDelegate) { //, containerDelegate: ) {
        self.delegate = delegate
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
                    self.delegate?.failed(error: TinderError.noUsersFound)
                }
            case .failure(let error):
                self.delegate?.failed(error: error)
            }
        }
    }
}
