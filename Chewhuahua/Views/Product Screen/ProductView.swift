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
	
	// MARK: - Properties
	@State var isIngredientsListExpanded: Bool = true
	@State var photoHeight: CGFloat = 0
	
	// MARK: View
	var body: some View {
		VStack {
			if let product = viewModel.product {
				GeometryReader { geometry in
					ZStack {
						VStack {
							AsyncImage(url: URL(string: product.photoURL),
									   content: { image in
								image
									.resizable()
									.scaledToFit()
									.overlay(Image("green_dog_bowl_check")
												.resizable()
												.scaledToFit()
												.frame(height: 40)
												.offset(x: 30, y: 20)
											 , alignment: .bottomTrailing)
								
							}) {
								ProgressView()
							}
							.frame(height: photoHeight,
								   alignment: .top)
							.transition(.move(edge: .bottom))
							.animation(.default)
							.onChange(of: isIngredientsListExpanded, perform: { isExpanded in
								photoHeight = isExpanded ? 0 : geometry.size.height * 0.5
							})
							
							Spacer()
						}
						.fullScreen()
						.padding(.vertical, 40)
						.background(Color.brandWhite)
						
						ProductDetailView(product: product, isIngredientsListExpanded: $isIngredientsListExpanded)
							.transition(.move(edge: .bottom))
							.animation(.interpolatingSpring(mass: 0.5, stiffness: 100, damping: 10, initialVelocity: 0.3))
							.shadow(color: .gray, radius: 5)
					}
				}
			} else {
				Text("Sorry, but we can't find this product in the database.")
			}
		}
		.fullScreen()
		.ignoresSafeArea(edges: isPresentedModally ? [.top] : [])
		.overlay(alignment: .topLeading, content: {
			if isPresentedModally {
				CloseButtonView(action: onCloseButtonTapped)
					.padding(.top, 15)
			}
		})
		.onAppear(perform: onAppear)
	}
	
	// MARK: - Close Button
	private var closeButton: some View {
		Button(action: onCloseButtonTapped, label: {
			Image(systemName: "xmark")
				.imageScale(.large)
				.foregroundColor(.brandBlack)
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
