//
//  UserView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import UIKit

class UserView: UIView {

    // MARK: - IBOutlets

    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var contentView: UIView!

    // MARK: - Inits

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {

        Bundle.main.loadNibNamed("UserView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageView.layer.borderWidth = 0.5
        userImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    // MARK: - Setup

    func setInfo(user: User) {

        nameLabel.text = user.fullName
        guard let imageUrl = user.picture?.large else { return }

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
}
