//
//  ProfileEditingView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import SwiftUI

struct ProfileEditingView: View {
	
	@State var image: UIImage?
	@State var name: String = ""
	@State var userName: String = ""
	
	var body: some View {
		VStack(spacing: 20) {
			Group {
				Button(action: {}) {
					Group {
						if let image = self.image {
							Image(uiImage: image)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.clipShape(Circle())
						}
						else {
							ImagePlaceholderView()
								.opacity(0.4)
								.overlay(
									Color.black.opacity(0.2)
										.overlay(
											Image(systemName: "plus.circle")
												.font(.title)
												.foregroundColor(.gray)
										)
								)
						}
					}
					.frame(dimension: 150)
				}
				.buttonStyle(AnimatedButtonStyle())
			}
			
			Text("Change your profile picture")
				.font(.app.subTitle)
				.fontWeight(.regular)
				.foregroundColor(.white)
				.padding(.vertical)
			
			TextFieldView(title: "Name", text: $name)
			
			TextFieldView(title: "Username", text: $userName)
			
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
