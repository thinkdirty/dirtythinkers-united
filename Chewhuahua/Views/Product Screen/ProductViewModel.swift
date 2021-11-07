//
//  ProductViewModel.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
	
	// MARK: - Properties
	let dataRepository: DataRepository
	let barcode: String
	
	@Published var product: UIProduct?
	
	var subscriptions = Set<AnyCancellable>()
	
	// MARK: - Methods
	init(dataRepository: DataRepository, barcode: String) {
		self.dataRepository = dataRepository
		self.barcode = barcode
		
		subsribe()
	}
	
	func fetchProduct() {
		guard let coreDataProduct = dataRepository.fetchProduct(with: barcode) else { return }
		product = UIProduct.transform(coreDataProduct)
	}
	
	// MARK: - Combine Methods
	private func subsribe() {
		$product
			.removeDuplicates()
			.compactMap { $0 }
			.sink(receiveValue: onProductUpdated)
			.store(in: &subscriptions)
	}
	
	private func onProductUpdated(_ product: UIProduct) {
		guard let coreDataProduct = dataRepository.fetchProduct(with: product.barcode) else { return }
		dataRepository.addProductViewRecord(for: coreDataProduct)
	}
}
