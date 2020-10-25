//
//  ConnectsViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import Foundation

//swiftlint:disable trailing_whitespace

protocol ConnectsViewModelDelegate: AnyObject {
    func addConnect(user: User)
}

protocol ConnectsTableViewDelegate: AnyObject {
    var delegate: ConnectsTableViewDelegate? { get set }
    func insertUser(_ user: User, at index: [IndexPath])
}

class ConnectsViewModel {
    
    weak var delegate: ConnectsTableViewDelegate?

    private var dataSource: [User] = []
    
    init(delegate: ConnectsTableViewDelegate) {
        self.delegate = delegate
    }
    
    func getConnectsCount() -> Int {
        return dataSource.count
    }
    
    func getUser(at index: Int) -> User? {
        guard index > dataSource.count-1 else { return nil }
        return dataSource[index]
    }
}

// MARK: - ConnectsViewModelDelegate

extension ConnectsViewModel: ConnectsViewModelDelegate {
    
    func addConnect(user: User) {
        dataSource.append(user)
        let index = [IndexPath(row: dataSource.count-1, section: 0)]
        delegate?.insertUser(user, at: index)
    }
}
