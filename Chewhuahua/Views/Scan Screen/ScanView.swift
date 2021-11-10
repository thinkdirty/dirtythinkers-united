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
	let makeProductView: (_ barcode: String, _ isPresentedModally: Bool, _ canAddViewingRecord: Bool) -> ProductView
	
	// MARK: - Properties
	@State var canScan: Bool = true
	
	// MARK: - View Properties
	var body: some View {
		VStack {
			if !viewModel.isProductViewPresented && canScan {
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
		.onAppear(perform: onAppear)
		.onDisappear(perform: onDisappear)
		
	}
	
	private var productView: some View {
		makeProductView(viewModel.barcode, true, true)
	}
	
	// MARK: - Methods
	private func onProductViewDismissed() {
		viewModel.barcode = ""
	}
	
	private func onAppear() {
		canScan = true
	}
	
	private func onDisappear() {
		canScan = false
	}
}
