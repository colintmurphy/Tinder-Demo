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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }

    // MARK: - Properties

    var viewModel: TinderViewModel?

    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TinderViewModel(viewModelDelegate: self, containerViewBounds: cardsView.bounds)
    }

    // MARK: - Swipe Button Actions

    @IBAction private func likeUser(_ sender: Any) {
        viewModel?.swipeRightViaButton()
    }

    @IBAction private func dislikeUser(_ sender: Any) {
        viewModel?.swipeLeftViaButton()
    }
}

// MARK: - TinderViewModelDelegate

extension TinderViewController: TinderViewModelDelegate {

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func addCardToContainer(card: SwipeableCardView, at index: Int) {
        cardsView.insertSubview(card, at: index)
    }

    func showAlert(title: String, message: String) {
        presentAlert(title: title, message: message)
    }

    func dismissView() {
        dismiss(animated: true, completion: nil)
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
