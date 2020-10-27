//
//  User.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/23/20.
//

import Foundation

struct RandomUserResponse: Decodable {
    var results: [User]?
}

struct User: Decodable {

    var name: Name?
    var location: Location?
    var birth: Birth?
    var picture: Picture?
    var cell: String?

    // MARK: Computed Properties
    var fullName: String {

        guard let firstName = name?.first, !firstName.isEmpty else { return "" }
        if let lastName = name?.last, !lastName.isEmpty {
            return firstName + " " + lastName
        } else {
            return firstName
        }
    }

    var fullLocation: String {

        var locationDetails = ""
        if let city = location?.city, !city.isEmpty {
            locationDetails = city
            if let state = location?.state, !state.isEmpty {
                locationDetails += ", " + state
            }
        } else if let state = location?.state {
            locationDetails = state
        }
        return locationDetails
    }

    var age: String {
        guard let value = birth?.age else { return "" }
        return String(value)
    }

    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case name
        case location
        case birth = "dob"
        case picture
        case cell
    }
}

// MARK: - Sub Structures

struct Name: Decodable {
    var first: String?
    var last: String?
}

struct Location: Decodable {
    var city: String?
    var state: String?
    var coordinates: Coordinates?
}

struct Birth: Decodable {
    var date: String?
    var age: Int?
}

struct Picture: Decodable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}

struct Coordinates: Decodable {
    var latitude: String?
    var longitude: String?
}
