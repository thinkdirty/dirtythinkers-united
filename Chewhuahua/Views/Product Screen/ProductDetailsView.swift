//
//  ProductDetailsView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-06.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
	// MARK: - Init Properties
	let product: UIProduct
	@Binding var isIngredientsListExpanded: Bool
	
	// MARK: - Properties
	@State var isBookMarked = true
	@State var width: CGFloat?
	@State var height: CGFloat?
	@State var maxWidth: CGFloat?
	@State var maxHeight: CGFloat?
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView {
				VStack {
					VStack(alignment: .leading, spacing: 5) {
						
						VStack(alignment: .leading, spacing: 5) {
							Group {
								Text(product.brand)
									.font(.system(size: 18, weight: .semibold, design: .rounded))
									.foregroundColor(.brandOrange)
								
								Text(product.name)
									.font(.system(.title, design: .rounded))
									.fontWeight(.heavy)
									.multilineTextAlignment(.leading)
								
								Text("\(product.weight) kg")
									.font(.system(size: 18, weight: .semibold, design: .rounded))
									.foregroundColor(.black)
								
								Text("$\(product.price)")
									.font(.system(size: 26, weight: .bold, design: .rounded))
									.foregroundColor(.black)
							}
							
							HStack(spacing: 3) {
								ForEach(1...5, id: \.self) { _ in
									Image(systemName: "star.fill")
										.foregroundColor(.yellow)
										.font(.system(size: 15))
								}
								
								Text("5.0")
									.font(.system(.headline))
									.padding(.leading, 10)
							}
							
						}
						.padding(.bottom, 15)
						
						Button(action: onIngredientsButtonTapped) {
							VStack {
								HStack {
									Text("Ingredients")
										.font(.system(size: 20, weight: .bold, design: .rounded))
										.foregroundColor(.black)
									Spacer()
									Image("plus")
										.foregroundColor(.brandBlue)
								}
								.padding(.bottom, isIngredientsListExpanded ? 7 : 100)
								
								if isIngredientsListExpanded {
									Divider()
										.frame(height: 0.25)
										.background(Color.brandLightGray)
										.padding(.bottom, 4)
								}
							}
						}
						
						if isIngredientsListExpanded {
							VStack {
								ForEach(product.ingredients, id: \.id) { ingredient in
									VStack {
										HStack {
											Text(ingredient.name)
												.font(.system(size: 18, weight: .regular, design: .rounded))
											Spacer()
											textRating(for: ingredient.rating)
												.font(.system(size: 18))
										}
										Divider()
											.frame(height: 0.25)
											.background(Color.brandLightGray)
									}
									.padding(.horizontal, 0)
									.padding(.vertical, 2)
								}
							}
							.padding(.bottom, 100)
						}
					}
					.padding()
					.frame(minWidth: .zero, idealWidth: width, maxWidth: maxWidth,
						   minHeight: .zero, idealHeight: height, maxHeight: maxHeight,
						   alignment: .topLeading)
					.background(Color.white)
					.cornerRadius(15)
					.onAppear(perform: {
						width = geometry.size.width
						height = geometry.size.height
						isIngredientsListExpanded = false
					})
					.onChange(of: isIngredientsListExpanded) { isExpanded in
						if isExpanded {
							width = nil
							height = nil
							maxWidth = .infinity
							maxHeight = .infinity
						} else {
							width = geometry.size.width
							height = geometry.size.height
							maxWidth = nil
							maxHeight = nil
						}
					}
					.overlay(alignment: .topTrailing) {
						Image(systemName: isBookMarked ? "bookmark.fill" : "bookmark")
							.font(.system(size: 40))
							.foregroundColor(.brandOrange)
							.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
							.offset(x: -15, y: -5)
							.onTapGesture(perform: { isBookMarked.toggle() })

					}
				}
				.frame(minWidth: .zero, maxWidth: .infinity,
					   minHeight: .zero, maxHeight: .infinity,
					   alignment: .bottom)
				.offset(y: isIngredientsListExpanded ? 50 : 0)
			}
		}
		.ignoresSafeArea(edges: .bottom)
	}
	
	// MARK: - Methods
	private func onIngredientsButtonTapped() {
		isIngredientsListExpanded.toggle()
	}
	
	private func textRating(for rating: Int16) -> some View {
		switch rating {
		case 0...3:
			return Text("✅")
		case 4...6:
			return Text("😐")
		case 7...10:
			return Text("😨")
		default:
			return Text("❔")
		}
	}
}
