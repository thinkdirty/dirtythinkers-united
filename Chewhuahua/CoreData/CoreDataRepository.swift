//
//  CoreDataRepository.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import CoreData

protocol DataRepository {
	func parseInitialData()
	func fetchProduct(with barcode: String) -> Product?
	func fetchAllProducts() -> [Product]
	func addProductViewRecord(for product: Product)
	func fetchProductViewRecords() -> [ProductViewRecord]
}

class RealCoreDataRepository: DataRepository {
	// MARK: - Properties
	let coreDataStack: CoreDataStack
	
	// MARK: - Methods
	init(coreDataStack: CoreDataStack) {
		self.coreDataStack = coreDataStack
	}
		
	func fetchIngredient(for name: String) -> Ingredient? {
		let ingredientRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
		ingredientRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Ingredient.name), name)
		
		do {
			let results = try coreDataStack.managedContext.fetch(ingredientRequest)
			let ingredient = results.last
			return ingredient
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
			return nil
		}
	}
	
	func fetchProduct(with barcode: String) -> Product? {
		let productsRequest: NSFetchRequest<Product> = Product.fetchRequest()
		productsRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Product.barcode), barcode)
		
		do {
			let results = try coreDataStack.managedContext.fetch(productsRequest)
			let product = results.last
			return product
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
			return nil
		}
	}
	
	func fetchAllProducts() -> [Product] {
		let productRequest: NSFetchRequest<Product> = Product.fetchRequest()
		
		do {
			let products = try coreDataStack.managedContext.fetch(productRequest)
			return products
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
			return []
		}
	}
	
	func addProductViewRecord(for product: Product) {
		let productViewRecord = ProductViewRecord(context: coreDataStack.managedContext)
		productViewRecord.timestamp = Date()
		productViewRecord.product = product
		
		do {
			try coreDataStack.saveContext()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
		}
	}
	
	func fetchProductViewRecords() -> [ProductViewRecord] {
		let productViewRecordRequest: NSFetchRequest<ProductViewRecord> = ProductViewRecord.fetchRequest()
		
		do {
			let records = try coreDataStack.managedContext.fetch(productViewRecordRequest)
			return records
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
			return []
		}
	}
	
	// MARK: - Set Initial Mock Data
	func generateProduct(with barcode: String, brand: String, name: String, photoURL: String, price: Float, rating: Float, weight: Float, ingredients: String) {

		let product = Product(context: coreDataStack.managedContext)
		product.barcode = barcode
		product.brand = brand
		product.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
		product.photoURL = photoURL
		product.price = price
		product.rating = rating
		product.weight = weight
		
		let ingredientNames = ingredients.components(separatedBy: ",")
		ingredientNames.forEach { name in
			let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
			if let ingredient = fetchIngredient(for: trimmedName) {
				product.addToIngredients(ingredient)
			} else {
				// Create new ingredient
				let ingredient = Ingredient(context: coreDataStack.managedContext)
				ingredient.name = trimmedName
				ingredient.rating = Int16.random(in: 0...10)
				
				product.addToIngredients(ingredient)
			}
		}
	}
	
	func parseInitialData() {
		generateProduct(with: "0725272730706",
						brand: "Purina ONE",
						name: "Smartblend Natural Dry Dog Food, Lamb & Rice",
						photoURL: "https://m.media-amazon.com/images/I/71dTUSKYGyL._AC_SL1500_.jpg",
						price: 39.99,
						rating: 4.7,
						weight: 14,
						ingredients: "Lamb (Source of Glucosamine), Rice Flour, Whole Grain Corn, Whole Grain Wheat, Chicken By-Product Meal (Source of Glucosamine), Corn Gluten Meal, Soybean Meal, Beef Fat Naturally Preserved with Mixed-Tocopherols, Mono and Dicalcium Phosphate, Glycerin, Calcium Carbonate, Liver Flavour, Salt, Caramel Colour, Potassium Chloride, Dried Carrots, Dried Peas, Vitamins [Vitamin E Supplement, Niacin (Vitamin B-3), Vitamin A Supplement, Calcium Pantothenate (Vitamin B-5), Thiamine Mononitrate (Vitamin B-1), Vitamin B-12 Supplement, Riboflavin Supplement (Vitamin B-2), Pyridoxine Hydrochloride (Vitamin B-6), Folic Acid (Vitamin B-9), Menadione Sodium Bisulfite Complex (Vitamin K), Vitamin D-3 Supplement, Biotin (Vitamin B-7)], Minerals [Zinc Sulphate, Ferrous Sulphate, Manganese Sulphate, Copper Sulphate, Calcium Iodate, Sodium Selenite], Choline Chloride, L-Lysine Monohydrochloride, Sulphur. V-4162-C")
		
		generateProduct(with: "0725272730701",
						brand: "Nature's Recipe",
						name: "Adult Grain Free Chicken, Sweet Potato & Pumpkin Recipe Dog Food",
						photoURL: "https://m.media-amazon.com/images/I/91g4gi+d3zL._AC_SL1500_.jpg",
						price: 52.98,
						rating: 4.3,
						weight: 10.8,
						ingredients: "Mono and Dicalcium Phosphate, Glycerin, Calcium Carbonate, Liver Flavour, Salt, Caramel Colour, Potassium Chloride, Dried Carrots, Dried Peas, Vitamins [Vitamin E Supplement, Niacin (Vitamin B-3), Vitamin A Supplement, Calcium Pantothenate (Vitamin B-5), Thiamine Mononitrate (Vitamin B-1), Vitamin B-12 Supplement, Riboflavin Supplement (Vitamin B-2), Pyridoxine Hydrochloride (Vitamin B-6), Folic Acid (Vitamin B-9), Menadione Sodium Bisulfite Complex (Vitamin K), Vitamin D-3 Supplement, Biotin (Vitamin B-7)], Minerals [Zinc Sulphate, Ferrous Sulphate, Manganese Sulphate, Copper Sulphate, Calcium Iodate, Sodium Selenite], Choline Chloride, L-Lysine Monohydrochloride, Sulphur. V-4162-C")
		
		generateProduct(with: "0725272730702",
						brand: "PEDIGREE VITALITY+",
						name: "Dry Food for Dogs Grilled Steak and Vegetable Flavour Dog Dry",
						photoURL: "https://m.media-amazon.com/images/I/81K8Gg5CvoS._AC_SL1500_.jpg",
						price: 34.98,
						rating: 3.5,
						weight: 20,
						ingredients: "Lamb (Source of Glucosamine), Rice Flour, Whole Grain Corn, Whole Grain Wheat, Chicken By-Product Meal (Source of Glucosamine), Corn Gluten Meal, Soybean Meal, Beef Fat Naturally Preserved with Mixed-Tocopherols, Mono and Dicalcium Phosphate, Glycerin, Calcium Carbonate, Riboflavin Supplement (Vitamin B-2), Pyridoxine Hydrochloride (Vitamin B-6), Folic Acid (Vitamin B-9), Menadione Sodium Bisulfite Complex (Vitamin K), Vitamin D-3 Supplement, Biotin (Vitamin B-7)], Minerals [Zinc Sulphate, Ferrous Sulphate, Manganese Sulphate, Copper Sulphate, Calcium Iodate, Sodium Selenite], Choline Chloride, L-Lysine Monohydrochloride, Sulphur. V-4162-C")

		generateProduct(with: "0725272730703",
						brand: "Hill's",
						name: "Science Diet Adult Sensitive Stomach & Skin Dry Dog Food, Chicken Recipe",
						photoURL: "https://m.media-amazon.com/images/I/81B3Kv7FUcL._AC_SL1500_.jpg",
						price: 62.99,
						rating: 4.2,
						weight: 15,
						ingredients: "Lamb (Source of Glucosamine), Dried Carrots, Dried Peas, Vitamins [Vitamin E Supplement, Niacin (Vitamin B-3), Vitamin A Supplement, Calcium Pantothenate (Vitamin B-5), Thiamine Mononitrate (Vitamin B-1), Vitamin B-12 Supplement, Riboflavin Supplement (Vitamin B-2), Pyridoxine Hydrochloride (Vitamin B-6), Folic Acid (Vitamin B-9), Menadione Sodium Bisulfite Complex (Vitamin K), Vitamin D-3 Supplement, Biotin (Vitamin B-7)], Minerals [Zinc Sulphate, Sodium Selenite], Choline Chloride, L-Lysine Monohydrochloride, Sulphur. V-4162-C")
		
		do {
			try coreDataStack.saveContext()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
		}
	}
}
