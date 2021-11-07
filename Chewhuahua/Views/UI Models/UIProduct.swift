//
//  UIProduct.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-06.
//

import Foundation
import UIKit

struct UIProduct: Identifiable {
	var id: String { barcode }
	
	let barcode: String
	let brand: String
	let name: String
	let photoURL: String
	let price: String
	let rating: String
	let weight: String
	let ingredients: [UIIngredient]
	
	static func transform(_ coreDataProducts: [Product]) -> [UIProduct] {
		var products: [UIProduct] = []
		
		coreDataProducts.forEach { coreDataProduct in
			guard let barcode = coreDataProduct.barcode,
				  let brand = coreDataProduct.brand,
				  let productName = coreDataProduct.name,
				  let photoURL = coreDataProduct.photoURL,
				  let coreDataIngredients = coreDataProduct.ingredients else { return }
			
			let ingredients: [UIIngredient] = UIIngredient.transform(coreDataIngredients)
			
			let product = UIProduct(barcode: barcode,
									brand: brand,
									name: productName,
									photoURL: photoURL,
									price: coreDataProduct.price.formatted(.number.precision(.fractionLength(2))),
									rating: coreDataProduct.rating.formatted(.number.precision(.fractionLength(1))),
									weight: coreDataProduct.weight.formatted(.number.precision(.fractionLength(2))),
									ingredients: ingredients)
			
			products.append(product)
		}
		
		return products
	}
	
	static func transform(_ product: Product) -> UIProduct? {
		let singleProductArray = [product]
		return transform(singleProductArray).first
	}
}

extension UIProduct: Equatable {
	static func == (lhs: UIProduct, rhs: UIProduct) -> Bool {
		return lhs.barcode == rhs.barcode
	}
}
