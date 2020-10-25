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

    enum CodingKeys: String, CodingKey {
        case name
        case location
        case birth = "dob"
        case picture
    }
}

struct Name: Decodable {
    var first: String?
    var last: String?
}

struct Location: Decodable {
    var city: String?
    var state: String?
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
