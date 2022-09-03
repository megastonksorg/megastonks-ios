//
//  SlidingButtonView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-08-28.
//

import SwiftUI

struct SlidingButtonView: View {
	let height: CGFloat = 60
	let buttonDiameter: CGFloat = 50
	let defaultXOffset: CGFloat = 6
	let offsetAnimation: Animation = .interactiveSpring(response: 0.4)
	
	@State var isSliding: Bool = false
	@State var inverseProgress: CGFloat = 1.0
	@State var xOffset: CGFloat
	
	init() {
		self._xOffset = State(initialValue: defaultXOffset)
	}
	
	var body: some View {
		HStack {
			GeometryReader { proxy in
				let width: CGFloat = proxy.frame(in: .local).width
				let maxXTravelDistance: CGFloat = width - (buttonDiameter + defaultXOffset / 2)
				HStack {
					ZStack(alignment: .leading) {
						if self.inverseProgress < 1 {
							Capsule()
								.fill(LinearGradient.red)
								.frame(width: width)
								.offset(x: xOffset - maxXTravelDistance)
								.animation(.default, value: xOffset)
								.clipShape(Capsule())
								.background(Color.black.clipShape(Capsule()))
						}
						Circle()
							.fill(Color.app.red)
							.frame(dimension: buttonDiameter, alignment: .leading)
							.offset(x: xOffset)
							.animation(offsetAnimation, value: xOffset)
							.gesture(
								DragGesture()
									.onChanged { value in
										let xDistance  = value.translation.width
										
										if (defaultXOffset...maxXTravelDistance).contains(xDistance) {
											self.isSliding = true
											self.xOffset = value.translation.width
											self.inverseProgress = 1 - (xDistance / maxXTravelDistance)
										}
									}
									.onEnded { _ in
										//Allow tolerance of 1 when completing actino
										if self.xOffset < maxXTravelDistance - 1  {
											self.xOffset = defaultXOffset
											self.isSliding = false
											withAnimation(offsetAnimation) {
												self.inverseProgress = 1.0
											}
										}
									}
							)
					}
				}
				.frame(width: width, height: proxy.size.height, alignment: .leading)
			}
			.frame(height: self.height)
		}
		.background(
			ZStack {
				Capsule()
					.fill(Color.black)
				Text("Slide to cast your vote")
					.font(.system(.body, design: .rounded, weight: .medium))
					.foregroundStyle(LinearGradient.shine)
					.opacity(self.inverseProgress)
			}
		)
		.overlay(
			Capsule()
				.stroke(self.isSliding ? LinearGradient.red : LinearGradient.gray)
		)
	}
}

struct SlidingButtonView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Spacer()
			SlidingButtonView()
				.padding(.horizontal, 40)
		}
	}
}
