//
//  MainScreenViewModel.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 13.02.2024.
//

import Foundation

class MainScreenViewModel {
    var productTitles: [String] = []
    var productPrices: [Double] = []

    func fetchProducts(completion: @escaping () -> Void) {
        let apiClient = APIClient()
        apiClient.fetchProducts { [weak self] products in
            guard let products = products else {
                completion()
                return
            }
            self?.productTitles.removeAll()
            self?.productPrices.removeAll()

            for product in products {
                self?.productTitles.append(product.title)
                self?.productPrices.append(product.price)
            }
            completion()
        }
    }
}
