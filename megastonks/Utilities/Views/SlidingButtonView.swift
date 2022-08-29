//
//  SlidingButtonView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-08-28.
//

import SwiftUI

struct SlidingButtonView: View {
	let height: CGFloat = 60
	var body: some View {
		HStack {
			GeometryReader { proxy in
				HStack {
					Circle()
						.fill(Color.red)
						.frame(dimension: 50)
						.offset(x: 6)
				}
				.frame(height: proxy.size.height)
			}
			.frame(height: self.height)
		}
		.background(Color.black, in: Capsule())
		.overlay(Capsule().stroke(Color.app.cardStroke, lineWidth: 2))
	}
}

struct SlidingButtonView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Spacer()
			SlidingButtonView()
		}
	}
}
