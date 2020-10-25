//
//  ConnectTableViewCell.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class ConnectTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var connectImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
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
