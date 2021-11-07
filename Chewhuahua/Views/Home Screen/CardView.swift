//
//  CardView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-06.
//

import Foundation
import SwiftUI

struct ProductCardView: View {
	let productName: String
	let photoURL: String
	
	@Binding var isShowDetails: Bool
	
	var body: some View {
		ZStack {
			GeometryReader { geometry in
				AsyncImage(url: URL(string: photoURL),
						   content: { image in
					image
						.resizable()
						.scaledToFit()
						.frame(width: geometry.size.width, height: geometry.size.height)
						.cornerRadius(self.isShowDetails ? 0 : 15)
						.overlay(
							VStack {
								Text(self.productName)
									.font(.system(.headline, design: .rounded))
									.fontWeight(.heavy)
									.padding(10)
									.background(Color.white)
									.padding([.bottom, .leading])
									.opacity(self.isShowDetails ? 0.0 : 1.0)
									.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
									.shadow(color: .white, radius: 0)
							}
							.shadow(color: .gray, radius: 5)
						)
				},
						   placeholder: {
					ProgressView()
						.scaleEffect(1.5)
						.fullScreen()
				})
			}
		}
	}
}
