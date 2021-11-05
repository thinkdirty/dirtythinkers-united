//
//  BarcodeScannerView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import AVFoundation
import Foundation
import SwiftUI
import Vision

struct BarcodeScannerView: UIViewRepresentable {
	typealias UIViewType = CameraView
	
	// MARK: - Properties
	@Binding var barcode: String
	
	func makeUIView(context: Context) -> UIViewType {
		return UIViewType()
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		context.coordinator.setupDetection(uiView)
	}
	
	func makeCoordinator() -> BarcodeScannerView.Coordinator {
		return Coordinator(self)
	}
}
