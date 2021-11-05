//
//  Extension+View.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation
import SwiftUI

// MARK: - Full Screen View
struct FullScreen: ViewModifier {
	func body(content: Content) -> some View {
		content
			.frame(minWidth: .zero,
				   maxWidth: .infinity,
				   minHeight: .zero,
				   maxHeight: .infinity)
	}
}

extension View {
	func fullScreen() -> some View {
		self.modifier(FullScreen())
	}
}

// MARK: - Custom Button View
struct CustomButton: ViewModifier {
	let width: CGFloat
	let height: CGFloat
	let cornerRadius: CGFloat
	let horizontalPadding: CGFloat
	let backgroundColor: Color
	let foregroundColor: Color
	
	func body(content: Content) -> some View {
		content
			.frame(minWidth: .zero,
				   maxWidth: width,
				   minHeight: .zero,
				   maxHeight: height)
			.background(backgroundColor)
			.foregroundColor(foregroundColor)
			.cornerRadius(cornerRadius)
			.padding(.horizontal, horizontalPadding)
	}
}

extension View {
	func customButton(width: CGFloat = .infinity,
					  height: CGFloat = 50,
					  cornerRadius: CGFloat = 4,
					  horizontalPadding: CGFloat = 16,
					  backgroundColor: Color = .black,
					  foregroundColor: Color = .white) -> some View
	{
		self.modifier(CustomButton(width: width,
								   height: height,
								   cornerRadius: cornerRadius,
								   horizontalPadding: horizontalPadding,
								   backgroundColor: backgroundColor,
								   foregroundColor: foregroundColor))
	}
}
