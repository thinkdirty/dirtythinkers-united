//
//  ProductViewModel.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation

class ProductViewModel: ObservableObject {
	
	// MARK: - Properties
	let dataRepository: DataRepository
	let barcode: String
	
	// MARK: - Methods
	init(dataRepository: DataRepository, barcode: String) {
		self.dataRepository = dataRepository
		self.barcode = barcode
	}
}
