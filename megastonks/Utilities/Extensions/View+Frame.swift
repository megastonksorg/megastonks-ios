//
//  View+Frame.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

extension View {
	func frame(dimension: CGFloat?) -> some View {
		frame(width: dimension, height: dimension)
	}
}
