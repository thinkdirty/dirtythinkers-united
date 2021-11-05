//
//  ProductView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import SwiftUI

struct ProductView: View {
	// MARK: - Init Properties
	@Environment(\.dismiss) var dismiss
	@StateObject var viewModel: ProductViewModel
	
	// MARK: View
	var body: some View {
		NavigationView {
			VStack {
				Text("Product with barcode:\n\(viewModel.barcode)")
					.fontWeight(.bold)
					.font(.title2)
					.multilineTextAlignment(.center)
					.padding()
			}
			.toolbar {
				Button("Done", action: onDoneButtonTapped)
			}
		}
	}
	
	// MARK: - Done Button
	func onDoneButtonTapped() {
		dismiss()
	}
}
