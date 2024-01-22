//
//  ViewController.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private var outerTableView: UITableView!
    private var apiManager: APIManagerProtocol = APIManager.shared
    private var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }

    private func setUI() {
        outerTableView.estimatedRowHeight(Constants.defaultRowHeight)
        outerTableView.registerNib(OuterTableCell.self)
        outerTableView.dataSource = self
        outerTableView.bounces = false
    }

    private func loadData() {
        apiManager.decodeJSONFromFile(fileName: "AppleProducts", fileType: "json") { [weak self] (result: Result<[Category], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories
                self.outerTableView.reloadData()
            case .failure(let error):
                print("Error decoding JSON: \(error)")
            }
        }
    }

    private func updateCellLayout(at indexPath: IndexPath) {
        if let cell = outerTableView.cellForRow(at: indexPath) {
            cell.layoutIfNeeded()
        }
    }

    private func performTableViewBatchUpdate() {
        UIView.animate(withDuration: Constants.animationDuration) { [unowned self] in
            outerTableView.performBatchUpdates(nil)
        }
    }
}

extension ViewController: OuterTableCellDelegate {

    func updateCellSize(forIndex: IndexPath) {
        DispatchQueue.main.async { [unowned self] in
            updateCellLayout(at: forIndex)
            performTableViewBatchUpdate()
        }
    }

    func heightChanged(index: IndexPath, value: Bool) {
        categories[index.row].isExpanded = value
        updateCellLayout(at: index)
        performTableViewBatchUpdate()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: OuterTableCell.self)
        if let category = categories[safe: indexPath.row] {
            cell.configuration(category: category, indexPath: indexPath, delegate: self)
        }
        return cell
    }
}
