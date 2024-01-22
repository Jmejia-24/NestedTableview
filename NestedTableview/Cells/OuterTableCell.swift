//
//  OuterTableCell.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import UIKit

final class OuterTableCell: UITableViewCell {

    @IBOutlet private var schoolNameLabel: UILabel!
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var innerTableView: InnerTableView!
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var arrowImageView: UIImageView!

    private var indexPath: IndexPath?
    private var category: Category?
    private weak var delegate: OuterTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    private func setUI() {
        innerTableView.registerNib(InnerTableCell.self)
        innerTableView.estimatedRowHeight(Constants.defaultRowHeight)
        innerTableView.delegate = self
        innerTableView.dataSource = self
        stackView.layer.cornerRadius = 8

        addTapEvent()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        indexPath = nil
        category = nil
        innerTableView.isHidden = true
        arrowImageView.transform = .identity
    }

    private func updateOuterTableView() {
        guard let indexPath = indexPath else { return }
        delegate?.updateCellSize(forIndex: indexPath)
    }

    private func addTapEvent() {
        let panGesture = UITapGestureRecognizer(target: self, action: #selector(handleActon))
        headerView.addGestureRecognizer(panGesture)
    }

    private func updateAppearance() {
        guard let isExpanded = category?.isExpanded else { return }
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            guard let self = self else { return }
            let upsideDown = CGAffineTransform(rotationAngle: -.pi * 0.999 )
            self.arrowImageView.transform = isExpanded ? upsideDown :.identity
        }
    }

    @objc private func handleActon() {
        guard let isExpanded = category?.isExpanded,
              let indexPath = indexPath else { return }

        innerTableView.isHidden = isExpanded

        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.delegate?.heightChanged(index: indexPath, value: !isExpanded)
        }
        category?.isExpanded = !isExpanded
        updateAppearance()
    }

    func configuration(category: Category, indexPath: IndexPath, delegate: OuterTableCellDelegate) {
        self.category = category
        self.indexPath = indexPath
        self.delegate = delegate

        updateAppearance()

        innerTableView.isHidden = !category.isExpanded
        schoolNameLabel.text = category.name

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            innerTableView.reloadData {
                self.updateOuterTableView()
            }
        }
    }
}

extension OuterTableCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        category?.products.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: InnerTableCell.self)
        if let product = category?.products[safe: indexPath.row] {
            cell.configCell(product: product)
        }
        updateOuterTableView()
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.invalidateIntrinsicContentSize()
        tableView.layoutIfNeeded()
    }
}
