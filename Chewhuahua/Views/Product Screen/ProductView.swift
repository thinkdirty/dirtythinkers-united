//
//  ProductView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import SwiftUI

struct ProductView: View {
	// MARK: - Environment Properties
	@Environment(\.dismiss) var dismiss

	// MARK: - Init Properties
	@StateObject var viewModel: ProductViewModel
	let isPresentedModally: Bool
	
	// MARK: View
	var body: some View {
		VStack {
			if let product = viewModel.product {
				AsyncImage(url: URL(string: product.photoURL),
						   content: { image in
					image
						.resizable()
						.scaledToFit()
					
				}) {
					Image(systemName: "photo")
						.resizable()
						.scaledToFit()
					Text("Sorry, but we can't find the image for this product")
				}
				.frame(minWidth: .zero, maxWidth: .infinity,
					   minHeight: 200, maxHeight: 200,
					   alignment: .center)
				.padding(.vertical, 20)
				.background(Color.white)
				.padding(.bottom, 5)
				
				ProductDetailView(product: product)
			} else {
				Text("Sorry, but we can't find this product in the database.")
			}
		}
		.fullScreen()
		.ignoresSafeArea(edges: isPresentedModally ? [.top] : [])
		.overlay(alignment: .topLeading, content: {
			if isPresentedModally {
				closeButton
					.padding(15)
			}
		})
		.onAppear(perform: onAppear)
	}
	
	// MARK: - Close Button
	private var closeButton: some View {
		Button(action: onCloseButtonTapped, label: {
			Image(systemName: "xmark")
				.imageScale(.large)
				.foregroundColor(.black)
				.shadow(color: .gray, radius: 3)
				.padding([.trailing, .bottom], 15)
		})
	}
	
	private func onCloseButtonTapped() {
		dismiss()
	}
	
	// MARK: - Methods
	private func onAppear() {
		viewModel.fetchProduct()
	}
		
	private func listRowBackground(for rating: Int16) -> some View {
		switch rating {
		case 0...3:
			return Color.green
		case 4...6:
			return Color.yellow
		case 7...10:
			return Color.red
		default:
			return Color.gray
		}
	}
}
