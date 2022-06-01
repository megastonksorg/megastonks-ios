//
//  ExpandedButtonStyle.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-31.
//

import SwiftUI

struct ExpandedButtonStyle: ButtonStyle {
	
	let shouldAnimate: Bool
	let invertedStyle: Bool
	
	@Environment(\.isEnabled) private var isEnabled
	
	public init (shouldAnimate: Bool = true, invertedStyle: Bool = false) {
		self.shouldAnimate = shouldAnimate
		self.invertedStyle = invertedStyle
	}
	
	public func makeBody(configuration: Configuration) -> some View {
		HStack {
			Spacer()
			configuration.label
				.foregroundColor(.white)
				.padding()
			Spacer()
		}
		.background {
			if invertedStyle {
				invertedButtonStyleView()
			} else {
				if isEnabled {
					Capsule()
						.fill(LinearGradient.megaStonksGreen)
				} else {
					invertedButtonStyleView()
				}
			}
		}
		.scaleEffect(shouldAnimate && configuration.isPressed ? 1.12 : 1)
		.animation(.easeOut(duration: 0.6), value: shouldAnimate && configuration.isPressed)
	}
	
	private func invertedButtonStyleView() -> some View {
		Capsule()
			.fill(.black)
			.overlay(
				Capsule()
					.stroke(lineWidth: 1)
					.fill(Color.gray)
			)
	}
}
