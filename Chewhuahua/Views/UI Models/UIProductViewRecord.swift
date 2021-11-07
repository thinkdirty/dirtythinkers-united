//
//  UIProductViewRecord.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-07.
//

import Foundation

struct UIProductViewRecord: Identifiable {
	var id: Date { timestamp }
	
	let timestamp: Date
	let product: UIProduct
	
	static func transform(_ coreDataProductViewRecords: [ProductViewRecord]) -> [UIProductViewRecord] {
		var productViewRecords: [UIProductViewRecord] = []
		
		coreDataProductViewRecords.forEach { coreDataRecord in
			guard let timestamp = coreDataRecord.timestamp,
				  let product = coreDataRecord.product,
				  let uiProduct = UIProduct.transform(product)
			else { return }
			
			let uiRecord = UIProductViewRecord(timestamp: timestamp, product: uiProduct)
			
			productViewRecords.append(uiRecord)
		 }
		
		return productViewRecords.sorted(by: \.timestamp, ascending: false)
	}
}
