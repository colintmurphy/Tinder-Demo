//
//  TinderViewController.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

class TinderViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardsView: CardsContainerView!

    // MARK: - Properties

    var viewModel: TinderViewModel?

    // MARK: - View Life Cycles

    override func viewDidLoad() {

        super.viewDidLoad()
        viewModel = TinderViewModel(viewModelDelegate: self, containerViewBounds: cardsView.bounds)
        setupNotificationObservers()
    }

    // MARK: - Notification Observers

    private func setupNotificationObservers() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showAlert),
            name: Notification.Name("ShowAlert"),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(presentView),
            name: Notification.Name("PresentView"),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dismissView),
            name: Notification.Name("DismissView"),
            object: nil)
    }

    @objc private func showAlert(notification: NSNotification) {

        if let title = notification.userInfo?["title"] as? String,
           let message = notification.userInfo?["message"] as? String {
            presentAlert(title: title, message: message)
        }
    }

    @objc private func presentView(notification: NSNotification) { }

    @objc private func dismissView(notification: NSNotification) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TinderViewModelDelegate

extension TinderViewController: TinderViewModelDelegate {

    func addCardToContainer(card: SwipeableCardView, at index: Int) {

        var cardViewFrame = cardsView.bounds
        let verticalInset = CGFloat(index) * CGFloat(14)
        let horizontalInset = (CGFloat(index) * CGFloat(14))

        cardViewFrame.origin.y += verticalInset
        cardViewFrame.origin.x += horizontalInset //For CardView: (horizontalInset - CGFloat(14))
        cardViewFrame.size.width -= 2 * horizontalInset
        card.frame = cardViewFrame

        cardsView.insertSubview(card, at: index)
    }

    func failed(error: TinderError) {

        switch error {
        case .badImageUrl, .couldNotDownloadImage, .couldNotUnwrapImage:
            break

        case .failedFetchingData:
            break

        case .noUsersFound:
            break
        }
    }
}
