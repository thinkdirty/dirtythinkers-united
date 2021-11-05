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
	let makeProductView: () -> ProductView
	
	var body: some View {
		Text("HistoryView")
	}
}
