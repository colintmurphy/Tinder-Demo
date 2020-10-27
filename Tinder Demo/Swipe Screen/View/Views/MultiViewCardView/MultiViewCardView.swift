//
//  MultiViewCardView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import UIKit

class MultiViewCardView: SwipeableCardView {

    // MARK: - IBOutlets

    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var contentSubView: UIView!
    @IBOutlet weak private var selectedView: UIView!
    @IBOutlet weak private var tabBar: UITabBar!
    @IBOutlet weak private var userBarItem: UITabBarItem!
    @IBOutlet weak private var premiumBarItem: UITabBarItem!

    // MARK: - Properties

    private var itemView: UIView!
    private weak var shadowView: UIView?
    private var user: User?

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

        Bundle.main.loadNibNamed("MultiViewCardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.layer.cornerRadius = 10

        itemView = UserView()
        itemView.frame = selectedView.bounds
        itemView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        selectedView.addSubview(itemView)

        tabBar.delegate = self
        tabBar.selectedItem = userBarItem
        tabBar.tintColor = .systemPink

        // MARK: Fix custom tabBarIcons' alignment
        tabBar.items![1].imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        tabBar.items![2].imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        tabBar.items![3].imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: -10, right: 0)
        tabBar.items![4].imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
    }

    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        guard shadowView == nil else { return }
        shadowView = addShadow(to: contentView)
    }

    func setInfo(user: User) {
        self.user = user
        setInfoForView()
    }

    private func setInfoForView() {

        guard let user = user else { return }

        if let view = itemView as? UserView {
            view.setInfo(user: user)
        } else if let view = itemView as? BirthdayView {
            view.setInfo(user: user)
        } else if let view = itemView as? LocationView {
            view.setInfo(user: user)
        } else if let view = itemView as? PhoneView {
            view.setInfo(user: user)
        }
    }
}

// MARK: - UITabBarDelegate

extension MultiViewCardView: UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        itemView.removeFromSuperview()

        switch item.tag {
        case 0:
            itemView = UserView()

        case 1:
            itemView = BirthdayView()

        case 2:
            itemView = LocationView()

        case 3:
            itemView = PhoneView()

        case 4:
            itemView = PremiumView()

        default:
            break
        }

        itemView.frame = selectedView.bounds
        itemView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        selectedView.addSubview(itemView)
        setInfoForView()
    }
}
