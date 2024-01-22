//
//  APIManager.swift
//  NestedTableview
//
//  Created by Byron on 21/1/24.
//

import Foundation

class APIManager {

    static let shared = APIManager()

    private init() {}
}

extension APIManager: APIManagerProtocol {
    func decodeJSONFromFile<T: Decodable>(fileName: String, fileType: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to find \(fileName).\(fileType) in the bundle."])))
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
