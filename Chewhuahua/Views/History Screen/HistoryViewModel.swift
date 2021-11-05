//
//  HistoryViewModel.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation

class HistoryViewModel: ObservableObject {
	
	// MARK: - Properties
	let dataRepository: DataRepository
	
	// MARK: - Methods
	init(dataRepository: DataRepository) {
		self.dataRepository = dataRepository
	}
}
