//
//  CardView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class CardView: SwipeableCardView {
    
    // MARK: - IBOutlets

    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var contentSubView: UIView!
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    
    // MARK: - Properties
    
    private weak var shadowView: UIView?
    
    // MARK: - Inits
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    deinit { }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentSubView.layer.cornerRadius = 15
    }
    
    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        guard shadowView == nil else { return }
        shadowView = addShadow(to: contentView)
    }
    
    func setInfo(name: String, location: String, age: String, imageUrl: String) {
        
        nameLabel.text = name
        ageLabel.text = age
        if location != "" {
            locationLabel.text = location
        } else {
            locationLabel.isHidden = true
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
}
