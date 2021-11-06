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
		return ScanView(viewModel: viewModel, makeProductView: makeProductView)
	}
	
	func makeScanViewModel() -> ScanViewModel {
		let repository = makeDataRepository()
		return ScanViewModel(dataRepository: repository)
	}
	
	// Product
	func makeProductView(_ barcode: String, isPresentedModally: Bool) -> ProductView {
		let viewModel = makeProductViewModel(barcode: barcode)
		return ProductView(viewModel: viewModel, isPresentedModally: isPresentedModally)
	}
	
	func makeProductViewModel(barcode: String) -> ProductViewModel {
		let repository = makeDataRepository()
		return ProductViewModel(dataRepository: repository, barcode: barcode)
	}
	
	// Data Repository
	func makeDataRepository() -> DataRepository {
		let repository: DataRepository = RealCoreDataRepository(coreDataStack: self.coreDataStack)
		let isInitialDataLoaded = UserDefaults.standard.bool(forKey: .isInitialDataLoaded)
		
		if !isInitialDataLoaded {
			repository.parseInitialData()
			UserDefaults.standard.set(true, forKey: .isInitialDataLoaded)
		}
		
		return repository
	}
}
