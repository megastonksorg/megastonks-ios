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
	
	func frame(size: CGSize?) -> some View {
		frame(width: size?.width, height: size?.height)
	}
	
	func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
		ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
	}
	
}
