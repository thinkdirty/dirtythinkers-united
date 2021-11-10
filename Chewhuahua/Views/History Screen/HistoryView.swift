//
//  HistoryView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import SwiftUI

struct HistoryView: View {
	// MARK: - Properties
	@StateObject var viewModel: HistoryViewModel
	let makeProductView: (_ barcode: String, _ isPresentedModally: Bool, _ canAddViewingRecord: Bool) -> ProductView
	
	var body: some View {
			VStack {
				if viewModel.productViewRecords.isEmpty {
					Text("You haven't viewed any products yet")
						.font(.system(size: 20, weight: .bold, design: .rounded))
						.padding(.horizontal, 20)
				} else {
					NavigationView {
					ScrollView {
						LazyVStack {
							ForEach(viewModel.productViewRecords, id: \.id) { record in
								NavigationLink {
									makeProductView(record.product.barcode, false, false)
										.navigationTitle("Product Details")
										.navigationBarTitleDisplayMode(.inline)
								} label: {
									HStack {
										VStack {
											AsyncImage(url: URL(string: record.product.photoURL), content: { image in
												image
													.resizable()
													.scaledToFit()
											}) {
												ProgressView()
											}
											.frame(width: 150, height: 150)
											.padding(5)
										}
										Spacer()
										VStack(alignment: .leading, spacing: 5) {
											Group {
												Text(record.product.brand)
													.font(.system(size: 16, weight: .semibold, design: .rounded))
													.foregroundColor(.brandOrange)
												
												Text(record.product.name)
													.font(.system(size: 18, weight: .semibold, design: .rounded))
													.fontWeight(.bold)
													.foregroundColor(.black)
													.multilineTextAlignment(.leading)
												
												Text("\(record.product.weight) kg")
													.font(.system(size: 16, weight: .semibold, design: .rounded))
													.foregroundColor(.black)
												
												Text("$\(record.product.price)")
													.font(.system(size: 22, weight: .bold, design: .rounded))
													.foregroundColor(.black)
											}
										}
										.overlay(Image("green_dog_bowl_check")
													.resizable()
													.scaledToFit()
													.frame(height: 40)
												 , alignment: .bottomTrailing)
									}
									.padding(15)
									.background(.white)
									.cornerRadius(15)
									.shadow(color: .gray, radius: 5)
									.padding(.vertical, 5)
								}
							}
						}
						.padding(.horizontal, 20)
					}
									.navigationTitle("History")
									.navigationBarTitleDisplayMode(.inline)
					}
					.navigationViewStyle(StackNavigationViewStyle())
				}
			}
		.onAppear(perform: onAppear)
	}
	
	// MARK: - Methods
	private func onAppear() {
		viewModel.fetchProductViewRecords()
	}
}
