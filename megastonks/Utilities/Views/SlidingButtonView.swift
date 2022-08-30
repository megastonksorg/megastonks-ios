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
					ZStack {

						
						Circle()
							.fill(Color.red)
							.frame(dimension: buttonDiameter)
							.offset(x: xOffset)
							.animation(.interactiveSpring(response: 0.4), value: xOffset)
					}
				}
				.frame(width: width, height: proxy.size.height, alignment: .leading)
				.gesture(
					DragGesture()
						.onChanged { value in
							let xDistance  = value.translation.width
							
							if (defaultXOffset...maxXTravelDistance).contains(xDistance) {
								self.xOffset = value.translation.width
							}
						}
						.onEnded { _ in
							//Allow tolerance of 1 when completing actino
							if self.xOffset < maxXTravelDistance - 1  {
								self.xOffset = defaultXOffset
							}
						}
				)
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
			}
		)
		.overlay(Capsule().stroke(Color.app.cardStroke, lineWidth: 2))
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
