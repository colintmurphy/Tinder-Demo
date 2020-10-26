//
//  TinderError.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import Foundation

enum TinderError: Error {
    case badImageUrl
    case couldNotDownloadImage
    case couldNotUnwrapImage
    case failedFetchingData
    case noUsersFound
}
