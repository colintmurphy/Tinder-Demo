//
//  TinderViewModel.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import UIKit

protocol TinderViewModelDelegate: AnyObject {
    func failed(error: TinderError)
    func showAlert(title: String, message: String)
    func addCardToContainer(card: SwipeableCardView, at index: Int)
    func dismissView()
    func startActivityIndicator()
    func stopActivityIndicator()
}

class TinderViewModel {

    // MARK: - Properties

    private let horizontalInset: CGFloat = 12.0
    private let verticalInset: CGFloat = 12.0
    private let numberOfVisibleCards: Int = 3
    private let containerViewBounds: CGRect

    var users: [User] = []
    var cardViews: [SwipeableCardView] = []
    var usersInContainer: [User] = []
    var connectsList: [User] = []

    weak var viewModelDelegate: TinderViewModelDelegate?

    // MARK: - Inits

    required init(viewModelDelegate: TinderViewModelDelegate, containerViewBounds: CGRect) {

        self.viewModelDelegate = viewModelDelegate
        self.containerViewBounds = containerViewBounds
        setupNotificationObservers()
        loadUsers()
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
            viewModelDelegate?.showAlert(title: title, message: message)
        }
    }

    @objc private func presentView(notification: NSNotification) { }

    @objc private func dismissView(notification: NSNotification) {
        viewModelDelegate?.dismissView()
    }

    // MARK: - Load Users

    private func loadUsers() {

        connectsList = DatabaseManager.shared.readAll()

        viewModelDelegate?.startActivityIndicator()
        NetworkManager.shared.fetchUsers(RandomUserResponse.self) { result in
            self.viewModelDelegate?.stopActivityIndicator()
            switch result {
            case .success(let response):
                if let users = response.results {
                    self.users = users
                    self.initContainerViewCards(with: users)
                } else {
                    self.viewModelDelegate?.failed(error: TinderError.noUsersFound)
                }
            case .failure(let error):
                self.viewModelDelegate?.failed(error: error)
            }
        }
    }

    // MARK: - Add Cards

    private func initContainerViewCards(with users: [User]) {

        self.users = users
        for _ in 0..<numberOfVisibleCards {
            insertNewCard()
        }
    }

    private func insertNewCard() {

        guard !users.isEmpty else { return }
        let user = users.removeLast()
        if let card = createUserCardView(with: user) {
            viewModelDelegate?.addCardToContainer(card: card, at: 0)
        }
        updateFrames()
    }

    private func createUserCardView(with user: User) -> SwipeableCardView? {

        guard (user.picture?.large) != nil else { return nil }
        let card = MultiViewCardView()
        card.setInfo(user: user)
        card.delegate = self
        cardViews.append(card)
        usersInContainer.append(user)
        return card
    }

    // MARK: - Set Card Frames

    private func setFrame(for cardView: SwipeableCardView, at index: Int) -> SwipeableCardView? {

        var cardViewFrame = containerViewBounds
        let verticalInset = CGFloat(index) * self.verticalInset
        let horizontalInset = (CGFloat(index) * self.horizontalInset)

        cardViewFrame.origin.y += verticalInset
        cardViewFrame.origin.x += horizontalInset//(horizontalInset - self.horizontalInset)
        cardViewFrame.size.width -= 2 * horizontalInset
        cardView.frame = cardViewFrame
        return cardView
    }

    private func updateFrames() {

        for (index, card) in cardViews.enumerated() {
            if let card = setFrame(for: card, at: index) {
                cardViews[index] = card
            }
        }
    }
}

// MARK: - SwipeableViewDelegate

extension TinderViewModel: SwipeableViewDelegate {

    func didSwipeLeft(on view: SwipeableView) {

        let card = cardViews.removeFirst()
        usersInContainer.removeFirst()
        insertNewCard()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            card.removeFromSuperview()
        }
    }

    func didSwipeRight(on view: SwipeableView) {

        let card = cardViews.removeFirst()
        let user = usersInContainer.removeFirst()
        connectsList.append(user)
        try? DatabaseManager.shared.insert(user: user)
        insertNewCard()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            card.removeFromSuperview()
        }
    }

    func swipeRightViaButton() {
        guard let card = cardViews.first else { return }
        card.swipeRight()
    }

    func swipeLeftViaButton() {
        guard let card = cardViews.first else { return }
        card.swipeLeft()
    }
}

// MARK: - ConnectsDataSource

extension TinderViewModel: ConnectsDataSource {

    func getConnectsCount() -> Int {
        return connectsList.count
    }

    func getConnect(at index: Int) -> User? {
        guard index < connectsList.count else { return nil }
        return connectsList[index]
    }
}
