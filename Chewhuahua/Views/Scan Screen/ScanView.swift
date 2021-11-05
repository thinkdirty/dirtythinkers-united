//
//  ScanView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import SwiftUI

struct ScanView: View {
	// MARK: - Init Properties
	@StateObject var viewModel: ScanViewModel
	let makeProductView: (_ barcode: String) -> ProductView
	
	// MARK: - View Properties
	var body: some View {
		VStack {
			if !viewModel.isProductViewPresented {
				BarcodeScannerView(barcode: $viewModel.barcode)
					.fullScreen()
					.ignoresSafeArea(edges: .top)
			} else {
				EmptyView()
			}
		}
		.sheet(isPresented: $viewModel.isProductViewPresented, onDismiss: onProductViewDismissed) {
			productView
		}
	}
	
	private var productView: some View {
		makeProductView(viewModel.barcode)
	}
	
	// MARK: - Methods
	private func onProductViewDismissed() {
		viewModel.barcode = ""
	}
}
