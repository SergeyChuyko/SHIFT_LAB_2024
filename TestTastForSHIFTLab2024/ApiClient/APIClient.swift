//
//  APIClient.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 14.02.2024.
//

import Foundation

struct Product: Codable {
    let title: String
    let price: Double
}

class APIClient {
    func fetchProducts(completion: @escaping ([Product]?) -> Void) {
        let url = URL(string: "https://fakestoreapi.com/products")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(products)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
