//
//  UIView.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import UIKit

extension UIView {
    var nsHeightConstraint: NSLayoutConstraint? {
        get {
            return constraints.filter {
                if $0.firstAttribute == .height, $0.relation == .equal {
                    return true
                }
                return false
            }.first
        }

        set {
            setNeedsLayout()
        }
    }
}
