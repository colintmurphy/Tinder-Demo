//
//  PhoneView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import UIKit

//swiftlint:disable trailing_whitespace

class PhoneView: UIView {

    @IBOutlet weak private var phoneLabel: UILabel!
    @IBOutlet weak private var callButton: UIButton!
    @IBOutlet weak private var messageButton: UIButton!
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
        
        Bundle.main.loadNibNamed("PhoneView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        callButton.layer.cornerRadius = callButton.bounds.height / 2
    }
    
    func setInfo(user: User) {
        phoneLabel.text = user.cell
    }
}
