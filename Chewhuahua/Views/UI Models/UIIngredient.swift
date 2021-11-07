//
//  UIIngredient.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-06.
//

import Foundation

struct UIIngredient: Identifiable {
	var id: String { name }
	
	let name: String
	let rating: Int16
	
	static func transform(_ coreDataIngredients: NSSet) -> [UIIngredient] {
		var ingredients: [UIIngredient] = []
		
		coreDataIngredients.forEach { element in
			guard let coreDataIngredient = element as? Ingredient,
				  let ingredientName = coreDataIngredient.name else { return }
			
			let ingredient = UIIngredient(name: ingredientName, rating: coreDataIngredient.rating)
			ingredients.append(ingredient)
		 }
		
		return ingredients.sorted(by: \.rating, ascending: false)
	}
}
