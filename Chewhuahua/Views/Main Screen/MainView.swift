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
	
	// MARK: - View Properties
	var body: some View {
		TabView {
			homeView
				.tabItem {
					Label("Home", systemImage: "house")
				}
			
			scanView
				.tabItem {
					Label("Scan", systemImage: "barcode.viewfinder")
				}
			
			historyView
				.tabItem {
					Label("History", systemImage: "gobackward")
				}
		}
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
