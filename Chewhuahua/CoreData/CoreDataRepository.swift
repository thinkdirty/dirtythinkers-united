//
//  CoreDataRepository.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import CoreData

protocol DataRepository {

}

class RealCoreDataRepository: DataRepository {
	// MARK: - Properties
	let coreDataStack: CoreDataStack
	
	// MARK: - Methods
	init(coreDataStack: CoreDataStack) {
		self.coreDataStack = coreDataStack
	}
}
