//
//  NetworkManager.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace
//swiftlint:disable identifier_name

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchUsers<T: Decodable>(_ t: T.Type, completion: @escaping (Result<T, TinderError>) -> Void) {
        
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return }
            
            do {
                let objData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(objData))
                }
            } catch {
                completion(.failure(.failedFetchingData))
            }
        }.resume()
    }
    
    func downloadImage(with urlString: String, completion: @escaping (Result<UIImage?, TinderError>) -> Void) {
    
        guard let url = URL(string: urlString) else {
            completion(.failure(.badImageUrl))
            return
        }
    
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            completion(.success(image))
        } catch {
            completion(.failure(.couldNotDownloadImage))
        }
    }
}
