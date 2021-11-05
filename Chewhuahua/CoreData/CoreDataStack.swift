//
//  CoreDataStack.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import CoreData

open class CoreDataStack {
	// MARK: - Properties
	public let modelName: String
	
	// MARK: - Computed Properties
	public lazy var managedContext: NSManagedObjectContext = {
		return self.storeContainer.viewContext
	}()
		
	public lazy var storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: self.modelName)
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	// MARK: - Methods
	public init(modelName: String) {
		self.modelName = modelName
	}
	
	public func saveContext() throws {
		guard managedContext.hasChanges else { return }
		
		try managedContext.save()
	}
}
