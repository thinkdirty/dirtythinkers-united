//
//  ScanViewModel.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import Combine

class ScanViewModel: ObservableObject {
	
	// MARK: - Properties
	let dataRepository: DataRepository
	
	@Published var barcode = ""
	@Published var isProductViewPresented = false
	
	var subscriptions = Set<AnyCancellable>()
	
	// MARK: - Methods
	init(dataRepository: DataRepository) {
		self.dataRepository = dataRepository
		
		subscribe()
	}
	
	// MARK: - Combine Methods
	private func subscribe() {
		$barcode
			.removeDuplicates()
			.sink(receiveValue: onBarcodeUpdated)
			.store(in: &subscriptions)
	}
	
	private func onBarcodeUpdated(_ value: String) {
		isProductViewPresented = !value.isEmpty
	}
}
