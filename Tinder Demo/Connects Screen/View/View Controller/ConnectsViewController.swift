//
//  ConnectsViewController.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

class ConnectsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }

    @IBOutlet private weak var emptyLabel: UILabel!

    // MARK: - Properties

    var connectsViewModel: ConnectsViewModel?
    var tinderViewModel: ConnectsDataSource?

    // MARK: - View Life Cycles

    override func viewDidLoad() {

        super.viewDidLoad()
        if let navController = tabBarController?.viewControllers?.first as? UINavigationController,
           let tinderView = navController.viewControllers.first as? TinderViewController {
            connectsViewModel = ConnectsViewModel(delegate: self, dataSource: tinderView.viewModel)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - ConnectsViewModelDelegate

extension ConnectsViewController: ConnectsViewModelDelegate {

    func hideEmptyConnectsLabel() {
        emptyLabel.isHidden = true
    }
}

// MARK: - UITableViewDelegate

extension ConnectsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ConnectsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectsViewModel?.getConnectsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectTableViewCell",
                                                       for: indexPath) as? ConnectTableViewCell
        else { fatalError("couldn't load ") }

        if let user = connectsViewModel?.getUser(at: indexPath.row) {
            cell.setInfo(user: user)
        }
        return cell
    }
}
