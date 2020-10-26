//
//  ConnectsViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import Foundation

//swiftlint:disable trailing_whitespace

protocol ConnectsDataSource: AnyObject {
    func getConnectsCount() -> Int
    func getConnect(at index: Int) -> User?
}

class ConnectsViewModel {
    
    // MARK: - Properties
    
    weak var dataSource: ConnectsDataSource?
    
    // MARK: - Inits
    
    init(dataSource: ConnectsDataSource?) {
        self.dataSource = dataSource
    }
    
    // MARK: - Getters
    
    func getConnectsCount() -> Int {
        return dataSource?.getConnectsCount() ?? 0
    }
    
    func getUser(at index: Int) -> User? {
        return dataSource?.getConnect(at: index)
    }
}
