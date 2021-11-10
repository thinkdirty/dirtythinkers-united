//
//  CloseButtonView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-09.
//

import Foundation
import SwiftUI

struct CloseButtonView: View {
	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			Image(systemName: "xmark.circle.fill")
				.font(.system(size: 30))
				.foregroundColor(.black)
				.opacity(0.7)
				.contentShape(Rectangle())
		}
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
		.padding(.trailing)
	}
}
