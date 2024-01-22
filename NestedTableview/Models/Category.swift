//
//  Category.swift
//  NestedTableview
//
//  Created by Byron on 20/1/24.
//

import Foundation

struct Category: Codable {
    var name: String
    var products: [Product]
    var isExpanded: Bool = false

    enum CodingKeys: String, CodingKey {
        case name
        case products
    }
}
