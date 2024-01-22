//
//  UITableView.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import UIKit

extension UITableView {

    public func estimatedRowHeight(_ height: CGFloat) {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = height
    }

    func dequeueReusableCell<T : UITableViewCell>(withClassIdentifier cell: T.Type) -> T {
        if let Cell = dequeueReusableCell(withIdentifier: String(describing: cell.self)) as? T {
            return Cell
        }
        fatalError(String(describing: cell.self))
    }

    func registerNib(_ cellClass: UITableViewCell.Type) {
        let id = String(describing: cellClass.self)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }

    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0) { [weak self] in
            guard let self = self else { return }
            self.reloadData()
        } completion: { _ in
            completion()
        }
    }
}

extension UITableView {

    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
