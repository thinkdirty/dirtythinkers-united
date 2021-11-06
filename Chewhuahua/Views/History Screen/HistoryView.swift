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
	let makeProductView: (_ barcode: String, _ isPresentedModally: Bool) -> ProductView
	
	var body: some View {
		NavigationView {
			List(viewModel.productViewRecords, id: \.self) { record in
				if let barcode = record.product?.barcode,
				   let productName = record.product?.name,
				   let photoURL = record.product?.photoURL
				{
					NavigationLink {
						makeProductView(barcode, false)
							.navigationTitle("Product Details")
							.navigationBarTitleDisplayMode(.inline)
					} label: {
						HStack {
							AsyncImage(url: URL(string: photoURL), content: { image in
								image
									.resizable()
									.scaledToFit()
							}) {
								Image(systemName: "photo")
									.resizable()
									.scaledToFit()
							}
							.frame(width: 30, height: 30)
							.padding(5)
							
							Spacer()
							
							Text(productName)
								.font(.subheadline)
						}
						.padding(.horizontal, 20)
						.padding(.vertical, 3)
					}
				}
			}
		}
		.onAppear(perform: onAppear)
	}
	
	// MARK: - Methods
	private func onAppear() {
		viewModel.fetchProductViewRecords()
	}
}
