//
//  MainViewModel.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation

class MainViewModel: ObservableObject {
	let coreDataStack: CoreDataStack

	init(coreDataStack: CoreDataStack) {
		self.coreDataStack = coreDataStack
	}
}
