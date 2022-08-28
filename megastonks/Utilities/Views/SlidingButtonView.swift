//
//  SlidingButtonView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-08-28.
//

import SwiftUI

struct SlidingButtonView: View {
	var body: some View {
		GeometryReader { proxy in
			HStack {
				
			}
			.frame(maxWidth: .infinity)
			.background(Color.black, in: Capsule())
		}
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
