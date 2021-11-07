//
//  ChewhuahuaApp.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import SwiftUI

@main
struct ChewhuahuaApp: App {
	// MARK: - Properties
	let injectionContainer = AppDependencyContainer()
	
	// MARK: - View Properties
    var body: some Scene {
        WindowGroup {
			mainView
        }
    }
	
	var mainView: some View {
		return injectionContainer.makeMainView()
			.environment(\.managedObjectContext, injectionContainer.coreDataStack.managedContext)
	}
	
	
	// MARK: - Methods
	init() {
		UITabBar.appearance().tintColor = UIColor(.brandOrange)

		let brandOrange = UIColor(.brandOrange)
		UINavigationBar.appearance().tintColor = brandOrange
		UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: brandOrange]
	}
}
