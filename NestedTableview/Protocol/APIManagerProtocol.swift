//
//  APIManagerProtocol.swift
//  NestedTableview
//
//  Created by Byron on 21/1/24.
//

import Foundation

protocol APIManagerProtocol {
    func decodeJSONFromFile<T: Decodable>(fileName: String, fileType: String, completion: @escaping (Result<T, Error>) -> Void)
}
