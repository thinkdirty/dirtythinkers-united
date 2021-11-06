//
//  HomeView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import SwiftUI

struct HomeView: View {
	// MARK: - Properties
	@StateObject var viewModel: HomeViewModel
	let makeProductView: (_ barcode: String, _ isPresentedModally: Bool) -> ProductView
	
	var body: some View {
		Text("HomeView")
	}
}

