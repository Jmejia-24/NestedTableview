//
//  Collection.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
