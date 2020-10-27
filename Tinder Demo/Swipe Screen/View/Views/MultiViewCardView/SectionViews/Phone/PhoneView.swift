//
//  PhoneView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import MessageUI
import UIKit

//swiftlint:disable trailing_whitespace

class PhoneView: UIView {
    
    // MARK: - IBOutlets

    @IBOutlet weak private var phoneLabel: UILabel!
    @IBOutlet weak private var callButton: UIButton!
    @IBOutlet weak private var messageButton: UIButton!
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
        
        Bundle.main.loadNibNamed("PhoneView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        callButton.layer.cornerRadius = callButton.bounds.height / 2
        callButton.addTarget(self, action: #selector(callUser), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(messageUser), for: .touchUpInside)
    }
    
    // MARK: - Set Data
    
    func setInfo(user: User) {
        phoneLabel.text = user.cell
    }
    
    // MARK: - Button Actions
    
    @objc private func callUser() {
        
        guard let number = phoneLabel.text,
              let url = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(url, options: [:]) { didOpen in
            guard !didOpen else { return }
            let messageDict: [String: String] = ["title": "Sorry",
                                                 "message": "Could not process your call at this time."]
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"),
                                            object: nil, userInfo: messageDict)
        }
    }
    
    @objc private func messageUser() {
        
        guard MFMessageComposeViewController.canSendText() else {
            let messageDict: [String: String] = ["title": "Sorry",
                                                 "message": "Could not process your message at this time."]
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"),
                                            object: nil, userInfo: messageDict)
            return
        }
        
        guard let phone = phoneLabel.text else {
            let messageDict: [String: String] = ["title": "Error",
                                                 "message": "No phone number found for user."]
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"),
                                            object: nil, userInfo: messageDict)
            return
        }
        
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        messageComposer.recipients = [phone]
        let messageDict: [String: MFMessageComposeViewController] = ["view": messageComposer]
        NotificationCenter.default.post(name: Notification.Name("PresentView"),
                                        object: nil, userInfo: messageDict)
    }
}

// MARK: - MFMessageComposeViewControllerDelegate

extension PhoneView: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        switch result {
        case .failed:
            let messageDict: [String: String] = ["title": "Sorry",
                                                 "message": "Unable to send your message."]
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"),
                                            object: nil, userInfo: messageDict)
            
        default:
            NotificationCenter.default.post(name: Notification.Name("DismissView"), object: nil)
        }
    }
}
