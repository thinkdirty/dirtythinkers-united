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
	let makeProductView: (_ barcode: String) -> ProductView
	
	var body: some View {
		Text("HomeView")
	}
}

