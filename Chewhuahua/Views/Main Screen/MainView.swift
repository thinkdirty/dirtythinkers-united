//
//  MainView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import SwiftUI
import CoreData

struct MainView: View {
	
	// MARK: - Init Properties
	@StateObject var mainViewModel: MainViewModel
	let makeHomeView: () -> HomeView
	let makeHistoryView: () -> HistoryView
	let makeScanView: () -> ScanView
	
	// MARK: - Properties
	@State var selectedView = 0
	
	// MARK: - View Properties
	var body: some View {
		TabView(selection: $selectedView) {
			homeView
				.tabItem {
					Image("home")
				}
				.tag(0)

			scanView
				.tabItem {
					Image(selectedView == 1 ? "bowl_active" : "bowl_inactive")
				}
				.tag(1)

			historyView
				.tabItem {
					Image("ball")
				}
				.tag(2)
		}
		.accentColor(.brandOrange)
	}
	
	var homeView: some View {
		return makeHomeView()
	}
	
	var historyView: some View {
		return makeHistoryView()
	}

	var scanView: some View {
		return makeScanView()
	}
}
