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
	
	func parseInitialData() {
		// Lamb (Source of Glucosamine), Rice Flour, Whole Grain Corn, Whole Grain Wheat
		let ingredient1 = Ingredient(context: coreDataStack.managedContext)
		ingredient1.name = "Lamb (Source of Glucosamine)"
		ingredient1.rating = 0
		
		let ingredient2 = Ingredient(context: coreDataStack.managedContext)
		ingredient2.name = "Rice Flour"
		ingredient2.rating = 4
		
		let ingredient3 = Ingredient(context: coreDataStack.managedContext)
		ingredient3.name = "Whole Grain Corn"
		ingredient3.rating = 2
		
		let ingredient4 = Ingredient(context: coreDataStack.managedContext)
		ingredient4.name = "Whole Grain Wheat"
		ingredient4.rating = 2
		
		let ingredient5 = Ingredient(context: coreDataStack.managedContext)
		ingredient5.name = "Sulphur. V-4162-C"
		ingredient5.rating = 8
		
		let product = Product(context: coreDataStack.managedContext)
		product.barcode = "0725272730706"
		product.name = "Purina ONE Smartblend Natural Dry Dog Food, Lamb & Rice 14 kg"
		product.photoURL = "https://m.media-amazon.com/images/I/71dTUSKYGyL._AC_SL1500_.jpg"
		
		product.addToIngredients(ingredient1)
		product.addToIngredients(ingredient2)
		product.addToIngredients(ingredient3)
		product.addToIngredients(ingredient4)
		product.addToIngredients(ingredient5)
		
		do {
			try coreDataStack.saveContext()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
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
}
