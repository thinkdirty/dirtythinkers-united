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
									.multilineTextAlignment(.center)
									.padding(10)
									.background(Color.brandWhite)
									.padding(.bottom)
									.opacity(self.isShowDetails ? 0.0 : 1.0)
									.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
									.offset(y: 100)
							}
						)
						.overlay(Image("green_dog_bowl_check")
									.resizable()
									.scaledToFit()
									.frame(height: self.isShowDetails ? 40 : 50)
									.padding(.trailing, 20)
									.offset(x: self.isShowDetails ? geometry.size.width * 0.25 : 0 ,
											y: self.isShowDetails ? 20 : 0)
								 , alignment: self.isShowDetails ? .bottom : .bottomTrailing)
				},
						   placeholder: {
					ProgressView()
						.scaleEffect(1.5)
						.fullScreen()
				})
			}
		}
		.padding(.bottom, 50)
	}
}
