//
//  ConnectsViewController.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/24/20.
//

import UIKit

//swiftlint:disable trailing_whitespace
//swiftlint:disable line_length

class ConnectsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    weak var delegate: ConnectsTableViewDelegate?
    var viewModel: ConnectsViewModel?
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ConnectsViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print(viewModel?.getConnectsCount())
    }
}

extension ConnectsViewController: ConnectsTableViewDelegate {
    
    func insertUser(_ user: User, at index: [IndexPath]) {
        //tableView.beginUpdates()
        //tableView.insertRows(at: index, with: .automatic)
        //tableView.endUpdates()
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
        return viewModel?.getConnectsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConnectTableViewCell.description(),
                                                       for: indexPath) as? ConnectTableViewCell else { fatalError("couldn't load ") }
        
        if let user = viewModel?.getUser(at: indexPath.row) {
            cell.setInfo(user: user)
        }
        return cell
    }
}
