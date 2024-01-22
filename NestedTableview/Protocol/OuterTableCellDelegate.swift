//
//  OuterTableCellDelegate.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import Foundation

protocol OuterTableCellDelegate: AnyObject {
    func heightChanged(index: IndexPath, value: Bool)
    func updateCellSize(forIndex: IndexPath)
}
