//
//  InnerTableCell.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import UIKit

final class InnerTableCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        subtitleLabel.text = ""
    }

    func configCell(product: Product?) {
        titleLabel.text = product?.name
        subtitleLabel.text = product?.productDescription
    }
}
