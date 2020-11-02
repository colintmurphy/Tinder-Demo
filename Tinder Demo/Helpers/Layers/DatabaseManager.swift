//
//  DatabaseManager.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 11/1/20.
//

import Foundation
import SQLite3

//swiftlint:disable identifier_name
//swiftlint:disable line_length

enum SqliteError: Error {

    case invalidDirectoryUrl
    case invalidBundleUrl
    case openDBFailed
    case prepareFailed
    case stepFailed
    case bindFailed
    case copyFailed
    case tableCreationError
    case insertFailed
    case deletingRow
    case readFailed
    case updateFailed
}

protocol DatabaseProvider: AnyObject {

    var dbPath: String { get }
    var dbName: String { get }

    init(dbName: String)

    func insert(user: User) throws
    func update(at id: Int, with user: User) throws
    func read(from id: Int) throws
    func delete(id: Int) throws
}

class DatabaseManager: DatabaseProvider {

    // MARK: - Properties

    var dbName: String
    var dbPath: String = ""
    private var dbPointer: OpaquePointer?

    static let shared = DatabaseManager()

    // MARK: - Init

    required init(dbName: String = "TinderDemoStorage.db") {
        self.dbName = dbName
        try? createDBIfRequired()
        dbPointer = try? openConnection()
        try? createTableIfRequired()
    }

    // MARK: - Handle Creation

    private func createDBIfRequired() throws {

        func copyDBIfNeeded(at destinationPath: String) throws {

            guard let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent(dbName)
            else { throw SqliteError.invalidBundleUrl }

            if FileManager.default.fileExists(atPath: destinationPath) {
                print("file exists")
                print(destinationPath)
            } else {
                print("file doesn't exist, copy from bundle")
                do {
                    try FileManager.default.copyItem(atPath: bundleUrl.path, toPath: destinationPath)
                } catch {
                    throw SqliteError.copyFailed
                }
            }
        }

        do {
            guard let docDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                  in: .userDomainMask).first
            else { throw SqliteError.invalidDirectoryUrl }

            dbPath = docDirectory.appendingPathComponent(dbName).path
            try copyDBIfNeeded(at: dbPath)
        } catch let error as SqliteError {
            throw error
        }
    }

    // MARK: - Connection

    func openConnection() throws -> OpaquePointer? {

        var opaquePointer: OpaquePointer?
        // its a swiftType for C pointer that is required to
        // access the db or to interact with the db

        if sqlite3_open(dbPath, &opaquePointer) == SQLITE_OK {
            print("DB open success")
            return opaquePointer
        } else {
            print("DB open failed")
            throw SqliteError.openDBFailed
        }
    }

    func closeConnection() {
        sqlite3_close(dbPointer)
    }

    deinit {
        sqlite3_close(dbPointer)
    }

    // MARK: - Create Table

    private func createTableIfRequired() throws {

        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Users (
                "Id"            INTEGER NOT NULL UNIQUE,
                "FirstName"     TEXT NOT NULL DEFAULT "",
                "LastName"      TEXT NOT NULL DEFAULT "",
                "City"          TEXT NOT NULL DEFAULT "",
                "State"         TEXT NOT NULL DEFAULT "",
                "Age"           INT NOT NULL DEFAULT "",
                "Birthday"      TEXT NOT NULL DEFAULT "",
                "Cell Number"   TEXT NOT NULL DEFAULT "",
                "Profile Pic"   TEXT NOT NULL DEFAULT "",
                PRIMARY KEY("Id" AUTOINCREMENT)
            )
        """
        let dbHandler = try prepareStatement(sql: createTableQuery)

        defer {
            sqlite3_finalize(dbHandler)
        }

        guard sqlite3_step(dbHandler) == SQLITE_DONE else {
            // takes ref to db and executes the statement
            print("table already exists")
            throw SqliteError.tableCreationError
        }
        print("table is created")
    }
}

// MARK: - CRUD

extension DatabaseManager {

    // MARK: - Create

    func insert(user: User) throws {

        guard let first = user.name?.first,
              let last = user.name?.last,
              let city = user.location?.city,
              let state = user.location?.state,
              let age = user.birth?.age,
              let date = user.birth?.date,
              let cell = user.cell,
              let imageUrl = user.picture?.large else { return }

        let query = """
            INSERT INTO Users (`FirstName`, `LastName`, `City`, `State`, `Age`, `Birthday`, `Cell Number`, `Profile Pic`)
            VALUES ('\(first)', '\(last)', '\(city)', '\(state)', '\(age)', '\(date)', '\(cell)', '\(imageUrl)')
        """

        let statement = try? prepareStatement(sql: query)
        defer {
            sqlite3_finalize(statement)
        }

        sqlite3_bind_text(statement, 1, (first as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 2, (last as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 3, (city as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 4, (state as NSString).utf8String, -1, nil)
        sqlite3_bind_int(statement, 5, Int32(age))
        sqlite3_bind_text(statement, 6, (date as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 7, (cell as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 8, (imageUrl as NSString).utf8String, -1, nil)

        if sqlite3_step(statement) == SQLITE_DONE {
            print("row inserted")
        } else {
            print("error inserting row")
            throw SqliteError.insertFailed
        }
    }

    func insertArray(users: [User]) throws {

        for user in users {

            if let first = user.name?.first,
                  let last = user.name?.last,
                  let city = user.location?.city,
                  let state = user.location?.state,
                  let age = user.birth?.age,
                  let date = user.birth?.date,
                  let cell = user.cell,
                  let imageUrl = user.picture?.large {

                let query = """
                    INSERT INTO Users (`FirstName`, `LastName`, `City`, `State`, `Age`, `Birthday`, `Cell Number`, `Profile Pic`)
                    VALUES ('\(first)', '\(last)', '\(city)', '\(state)', '\(age)', '\(date)', '\(cell)', '\(imageUrl)')
                """

                let statement = try? prepareStatement(sql: query)
                defer {
                    sqlite3_finalize(statement)
                }

                sqlite3_bind_text(statement, 1, (first as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (last as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 3, (city as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 4, (state as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 5, Int32(age))
                sqlite3_bind_text(statement, 6, (date as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 7, (cell as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 8, (imageUrl as NSString).utf8String, -1, nil)

                if sqlite3_step(statement) == SQLITE_DONE {
                    print("row inserted")
                } else {
                    print("error inserting row")
                    throw SqliteError.insertFailed
                }
            }
        }
    }

    // MARK: - Read

    func read(from id: Int) throws {

        let query = """
            SELECT * FROM Users
            WHERE Id == \(id)
        """

        let statement = try? prepareStatement(sql: query)
        defer {
            sqlite3_finalize(statement)
        }

        if sqlite3_step(statement) == SQLITE_ROW {
            if let first = sqlite3_column_text(statement, 1),
               let last = sqlite3_column_text(statement, 2),
               let city = sqlite3_column_text(statement, 3),
               let state = sqlite3_column_text(statement, 4),
               let date = sqlite3_column_text(statement, 6),
               let cell = sqlite3_column_text(statement, 7),
               let imageUrl = sqlite3_column_text(statement, 8) {

                let age = sqlite3_column_int(statement, 5)

                print("user read")
                let firstNameString = String(cString: first)
                let lastNameString = String(cString: last)
                let cityString = String(cString: city)
                let stateString = String(cString: state)
                let ageInt = Int(age)
                let dateString = String(cString: date)
                let cellString = String(cString: cell)
                let imageUrlString = String(cString: imageUrl)
                print(firstNameString, lastNameString, cityString, stateString, ageInt, dateString, cellString, imageUrlString)
            }
        } else {
            print("error reading id")
            throw SqliteError.readFailed
        }
    }

    func readAll() -> [User] {

        var results: [User] = []

        let query = "SELECT * FROM Users"
        let statement = try? prepareStatement(sql: query)

        defer {
            sqlite3_finalize(statement)
        }

        while sqlite3_step(statement) == SQLITE_ROW {

            if let first = sqlite3_column_text(statement, 1),
               let last = sqlite3_column_text(statement, 2),
               let city = sqlite3_column_text(statement, 3),
               let state = sqlite3_column_text(statement, 4),
               let date = sqlite3_column_text(statement, 6),
               let cell = sqlite3_column_text(statement, 7),
               let imageUrl = sqlite3_column_text(statement, 8) {
                let age = sqlite3_column_int(statement, 5)
                print("user read")

                let firstNameString = String(cString: first)
                let lastNameString = String(cString: last)
                let cityString = String(cString: city)
                let stateString = String(cString: state)
                let ageInt = Int(age)
                let dateString = String(cString: date)
                let cellString = String(cString: cell)
                let imageUrlString = String(cString: imageUrl)
                results.append(User(name: Name(first: firstNameString, last: lastNameString),
                                    location: Location(city: cityString, state: stateString, coordinates: nil),
                                    birth: Birth(date: dateString, age: ageInt),
                                    picture: Picture(large: imageUrlString, medium: imageUrlString, thumbnail: imageUrlString),
                                    cell: cellString))
            }
        }
        return results
    }

    // MARK: - Update

    func update(at id: Int, with user: User) throws {

        let query = """
            UPDATE Users
            SET FirstName = '\(user.name?.first ?? "")',
                LastName = '\(user.name?.last ?? "")',
                City = '\(user.location?.city ?? "")',
                State = '\(user.location?.state ?? "")'
                Age = '\(user.birth?.age ?? 0)'
                Birthday = '\(user.birth?.date ?? "")'
                Cell Number = '\(user.cell ?? "")'
                Profile Pic = '\(user.picture?.large ?? "")'
            WHERE Id = \(id)
        """

        let statement = try? prepareStatement(sql: query)
        defer {
            sqlite3_finalize(statement)
        }

        if sqlite3_step(statement) == SQLITE_DONE {
            print("row with value \(user)")
        } else {
            print("error updating row")
            throw SqliteError.updateFailed
        }
    }

    // MARK: - Delete

    func delete(id: Int) throws {

        let query = """
            DELETE FROM Users
            WHERE id = \(id)
        """

        let statement = try? prepareStatement(sql: query)
        defer {
            sqlite3_finalize(statement)
        }

        if sqlite3_step(statement) == SQLITE_DONE {
            print("Successfully deleted row.")
        } else {
            print("Could not delete row.")
            throw SqliteError.deletingRow
        }
    }
}

// MARK: - Prepare

extension DatabaseManager {

    func prepareStatement(sql: String) throws -> OpaquePointer? {

        var localPointer: OpaquePointer?
        if sqlite3_prepare(dbPointer, sql, -1, &localPointer, nil) == SQLITE_OK {
            // preps and compiles code into byte code, needed in every operation
            return localPointer
        } else {
            print("failed to prep statement")
            throw SqliteError.prepareFailed
        }
    }
}
