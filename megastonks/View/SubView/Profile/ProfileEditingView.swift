//
//  ProfileEditingView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import SwiftUI

struct ProfileEditingView: View {
	@State var image: UIImage?
	var body: some View {
		VStack(spacing: 10) {
			Group {
				if let image = self.image {
					Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.clipShape(Circle())
				}
				else {
					ImagePlaceholderView()
				}
			}
			.frame(dimension: 100)
			.overlay(
				Color.black.opacity(0.2)
					.overlay(
						Image(systemName: "plus.circle")
							.font(.title)
							.foregroundColor(.gray)
					)
			)
			
			Text("Change your profile picture")
				.font(.app.subTitle)
				.foregroundColor(.white)
			Spacer()
			
		}
		.background(Color.app.background)
	}
}

struct ProfileEditingView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileEditingView()
	}
}
