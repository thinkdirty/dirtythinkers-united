//
//  Extension+Sequence.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import Foundation

extension Sequence {
	func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool) -> [Element] {
		sorted { a, b in
			if ascending {
				return a[keyPath: keyPath] < b[keyPath: keyPath]
			} else {
				return a[keyPath: keyPath] > b[keyPath: keyPath]
			}
		}
	}
}
