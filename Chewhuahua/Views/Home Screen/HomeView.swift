//
//  HomeView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import SwiftUI

struct HomeView: View {
	// MARK: - Init Properties
	@StateObject var viewModel: HomeViewModel
	
	// MARK: - Properties
	@State private var isCardTapped = false
	@State private var currentProductIndex = 0
	@State var isIngredientsListExpanded: Bool = true
	
	@GestureState private var dragOffset: CGFloat = 0
	
	
	var body: some View {
		ZStack {
			VStack(alignment: .leading) {
				Text("Discover")
					.font(.system(.largeTitle, design: .rounded))
					.fontWeight(.black)
				
				Text("Explore the next treat for your puppy")
					.font(.system(.headline, design: .rounded))
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
			.padding(.top, 25)
			.padding(.leading, 20)
			.opacity(self.isCardTapped ? 0.0 : 1.0)
			.offset(y: self.isCardTapped ? -150 : 0)
			
			// Carousel
			GeometryReader { outerView in
				HStack(spacing: 0) {
					ForEach(viewModel.products.indices, id: \.self) { index in
						GeometryReader { innerView in
							ProductCardView(productName: viewModel.products[index].name,
											photoURL: viewModel.products[index].photoURL,
											isShowDetails: self.$isCardTapped)
								.offset(y: self.isCardTapped ? -innerView.size.height * 0.3 : 0)
						}
						.padding(.horizontal, self.isCardTapped ? 0 : 20)
						.opacity(self.currentProductIndex == index ? 1.0 : 0.7)
						.frame(width: outerView.size.width, height: self.currentProductIndex == index ? (self.isCardTapped ? outerView.size.height - 380 : 450) : 380)
						.onTapGesture {
							self.isCardTapped = true
						}
					}
				}
				.frame(width: outerView.size.width, height: outerView.size.height, alignment: .leading)
				.offset(x: -CGFloat(self.currentProductIndex) * outerView.size.width)
				.offset(x: self.dragOffset)
				.gesture(
					!self.isCardTapped ?
						
					DragGesture()
						.updating(self.$dragOffset, body: { (value, state, transaction) in
							state = value.translation.width
						})
						.onEnded({ (value) in
							let threshold = outerView.size.width * 0.35
							var newIndex = Int(-value.translation.width / threshold) + self.currentProductIndex
							newIndex = min(max(newIndex, 0), viewModel.products.count - 1)
							
							self.currentProductIndex = newIndex
						})
					
					: nil
				)
			}
			.animation(.interpolatingSpring(mass: 0.6, stiffness: 100, damping: 10, initialVelocity: 0.3))
			
			// Detail view
			if self.isCardTapped {
				ProductDetailView(product: viewModel.products[currentProductIndex], isIngredientsListExpanded: $isIngredientsListExpanded)
					.transition(.move(edge: .bottom))
					.animation(.interpolatingSpring(mass: 0.5, stiffness: 100, damping: 10, initialVelocity: 0.3))
					.shadow(color: .gray, radius: 5)
				
				CloseButtonView {
					self.isCardTapped = false
				}
			}
		}
		.onAppear(perform: onAppear)
		.onChange(of: isCardTapped, perform: addProductViewRecord)
	}
	
	// MARK: - Methods
	
	private func onAppear() {
		viewModel.fetchProducts()
	}
	
	private func addProductViewRecord(_ isCardTapped: Bool) {
		if isCardTapped {
			viewModel.addProductViewRecord(for: currentProductIndex)
		}
	}
}
