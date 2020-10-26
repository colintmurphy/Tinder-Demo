//
//  ConnectTableViewCell.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class ConnectTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var connectImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    // MARK: - Setup

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCustomImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCustomImage() {
        connectImageView.layer.cornerRadius = 15
        connectImageView.layer.borderWidth = 1.0
        connectImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - Set Info
    
    func setInfo(user: User) {
        
        nameLabel.text = user.fullName
        locationLabel.text = user.fullLocation
        if let age = user.birth?.age {
            ageLabel.text = String(age)
        }
        
        guard let imageUrl = user.picture?.large else { return }
        NetworkManager.shared.downloadImage(with: imageUrl) { results in
            switch results {
            case .success(let image):
                self.connectImageView.image = image
            case .failure(let error):
                print(error.localizedDescription, " in ConnectTableViewCell")
            }
        }
    }
}
