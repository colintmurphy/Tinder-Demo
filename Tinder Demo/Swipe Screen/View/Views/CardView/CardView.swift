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
    
    private weak var shadowView: UIView?
    private let kInnerMargin: CGFloat = 20.0
    
    var user: User!
    
    // MARK: - Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentSubView.layer.cornerRadius = 15
    }

    private func configureShadow() {
        
        if shadowView == nil {
            let shadowView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: contentSubView.bounds.width - (2 * kInnerMargin),
                                              height: contentSubView.bounds.height - (2 * kInnerMargin)))
            
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(0.0))
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
            insertSubview(shadowView, at: 0)
            self.shadowView = shadowView
        }
    }
    
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
}
