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
		let brandTealColor = UIColor(named: "brandTeal") ?? UIColor.systemTeal
		UINavigationBar.appearance().tintColor = brandTealColor
		UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: brandTealColor]
	}
}
