//
//  PremiumView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/27/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class PremiumView: UIView {

    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var signupButton: UIButton!
    @IBOutlet weak private var contentView: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("PremiumView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        signupButton.layer.cornerRadius = signupButton.bounds.height / 2
        signupButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
    }
    
    @objc private func presentAlert() {
        let messageDict: [String: String] = ["title": "Premium coming soon!",
                                             "message": ""]
        NotificationCenter.default.post(name: Notification.Name("ShowAlert"),
                                        object: nil, userInfo: messageDict)
    }
}
