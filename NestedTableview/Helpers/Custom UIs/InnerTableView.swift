//
//  InnerTableView.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import UIKit

class InnerTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        defaultInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }

    func defaultInit(){
        keyboardDismissMode = .onDrag
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        tableFooterView = UIView(frame: .zero)
        tableHeaderView = UIView(frame: .zero)
        sectionFooterHeight = 0
        sectionHeaderHeight = 0
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [unowned self] in
            if nsHeightConstraint != nil {
                nsHeightConstraint?.constant = contentSize.height + 10
            } else {
                NSLayoutConstraint.activate([
                    heightAnchor.constraint(equalToConstant: contentSize.height)
                ])
            }

            setNeedsDisplay()
        }
    }
}
