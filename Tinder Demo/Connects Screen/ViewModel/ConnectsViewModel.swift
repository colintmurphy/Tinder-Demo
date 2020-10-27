//
//  ConnectsViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import Foundation

protocol ConnectsDataSource: AnyObject {
    func getConnectsCount() -> Int
    func getConnect(at index: Int) -> User?
}

protocol ConnectsViewModelDelegate: AnyObject {
    func hideEmptyConnectsLabel()
}

class ConnectsViewModel {

    // MARK: - Properties

    weak var dataSource: ConnectsDataSource?
    weak var delegate: ConnectsViewModelDelegate?

    // MARK: - Inits

    init(delegate: ConnectsViewModelDelegate?, dataSource: ConnectsDataSource?) {
        self.delegate = delegate
        self.dataSource = dataSource
    }

    // MARK: - Getters

    func getConnectsCount() -> Int {

        if let count = dataSource?.getConnectsCount(),
           count > 0 {
            delegate?.hideEmptyConnectsLabel()
            return count
        }
        return 0
    }

    func getUser(at index: Int) -> User? {
        return dataSource?.getConnect(at: index)
    }
}
