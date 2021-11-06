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
	
	@Published var product: Product?
	
	var subscriptions = Set<AnyCancellable>()
	
	// MARK: - Methods
	init(dataRepository: DataRepository, barcode: String) {
		self.dataRepository = dataRepository
		self.barcode = barcode
		
		subsribe()
	}
	
	func fetchProduct() {
		product = dataRepository.fetchProduct(with: barcode)
	}
	
	// MARK: - Combine Methods
	private func subsribe() {
		$product
			.removeDuplicates()
			.compactMap { $0 }
			.sink(receiveValue: onProductUpdated)
			.store(in: &subscriptions)
	}
	
	private func onProductUpdated(_ product: Product) {
		dataRepository.addProductViewRecord(for: product)
	}
}
