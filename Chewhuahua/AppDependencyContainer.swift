//
//  AppDependencyContainer.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation

class AppDependencyContainer {
	// MARK: - Properties

	// Long-lived dependencies
	let sharedMainViewModel: MainViewModel
	let coreDataStack: CoreDataStack

	
	// MARK: - Methods
	init() {
		func makeCoreDataStack() -> CoreDataStack {
			return CoreDataStack(modelName: "Chewhuahua")
		}

		func makeMainViewModel(coreDataStack: CoreDataStack) -> MainViewModel {
			return MainViewModel(coreDataStack: coreDataStack)
		}
		
		let coreDataStack = makeCoreDataStack()
		self.coreDataStack = coreDataStack
		self.sharedMainViewModel = makeMainViewModel(coreDataStack: coreDataStack)
		
		print("Application directory: \(NSHomeDirectory())")
	}
	
	// Main
	func makeMainView() -> MainView {
		return MainView(mainViewModel: self.sharedMainViewModel,
						makeHomeView: makeHomeView,
						makeHistoryView: makeHistoryView,
						makeScanView: makeScanView)
	}
	
	// Home
	func makeHomeView() -> HomeView {
		let viewModel = makeHomeViewModel()
		return HomeView(viewModel: viewModel, makeProductView: makeProductView)
	}
	
	func makeHomeViewModel() -> HomeViewModel {
		let repository = makeDataRepository()
		return HomeViewModel(dataRepository: repository)
	}
	
	// History
	func makeHistoryView() -> HistoryView {
		let viewModel = makeHistoryViewModel()
		return HistoryView(viewModel: viewModel, makeProductView: makeProductView)
	}
	
	func makeHistoryViewModel() -> HistoryViewModel {
		let repository = makeDataRepository()
		return HistoryViewModel(dataRepository: repository)
	}
	
	// Scan
	func makeScanView() -> ScanView {
		let viewModel = makeScanViewModel()
		return ScanView(viewModel: viewModel)
	}
	
	func makeScanViewModel() -> ScanViewModel {
		let repository = makeDataRepository()
		return ScanViewModel(dataRepository: repository)
	}
	
	// Product
	func makeProductView() -> ProductView {
		let viewModel = makeProductViewModel()
		return ProductView(viewModel: viewModel)
	}
	
	func makeProductViewModel() -> ProductViewModel {
		let repository = makeDataRepository()
		return ProductViewModel(dataRepository: repository)
	}
	
	// Data Repository
	func makeDataRepository() -> DataRepository {
		return RealCoreDataRepository(coreDataStack: self.coreDataStack)
	}
}
