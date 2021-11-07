//
//  HomeViewModel.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation

class HomeViewModel: ObservableObject {
	
	// MARK: - Init Properties
	let dataRepository: DataRepository
	
	// MARK: - Properties
	@Published var products: [UIProduct] = []
	
	// MARK: - Methods
	init(dataRepository: DataRepository) {
		self.dataRepository = dataRepository
	}
	
	func fetchProducts() {
		let coreDataProducts = dataRepository.fetchAllProducts()
		products = UIProduct.transform(coreDataProducts)
	}
}
