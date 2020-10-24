//
//  CardView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/23/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class CardView: SwipeableCardView {
    
    // MARK: - IBOutlets

    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    
    // MARK: - Methods

    func setInfo(name: String, location: String?, age: Int?, imageUrl: String) {

        nameLabel.text = name
        
        if let location = location {
            locationLabel.text = location
        } else {
            locationLabel.isHidden = true
        }
        
        if let age = age {
            ageLabel.text = String(age)
        }
        
        NetworkManager.shared.downloadImage(with: imageUrl) { results in
            switch results {
            case .success(let image):
                DispatchQueue.main.async {
                    self.userImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription, " with image url ", imageUrl)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
    }

    private func configureShadow() { }
}
