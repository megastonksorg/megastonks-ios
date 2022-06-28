//
//  Colors.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

extension Color {
	static var megaStonksGray: Color { .init(.init(hex: "A1A1AA")) }
	static var megaStonksGreen: Color { .init(.init(hex: "3AD77E")) }
	static var megaStonksGreenDark: Color { .init(.init(hex: "4BBD20")) }
}

public extension Color {
	enum app {}
}

public extension Color.app {
	static let background: Color = Color.black
}
