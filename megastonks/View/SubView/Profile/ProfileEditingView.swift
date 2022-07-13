//
//  ProfileEditingView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import SwiftUI

struct ProfileEditingView: View {
	
	@StateObject private var viewModel: ProfileEditingView.ViewModel
	
	init() {
		self._viewModel = StateObject.init(wrappedValue: ViewModel())
	}
	
	var body: some View {
		VStack(spacing: 20) {
			Group {
				Button(action: { viewModel.selectImageFromLibrary() }) {
					Group {
						if let image = viewModel.image {
							Image(uiImage: image)
								.resizable()
								.aspectRatio(contentMode: .fill)
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
				.padding(.top)
			}
			
			Text("Change your profile picture")
				.font(.app.subTitle)
				.fontWeight(.regular)
				.foregroundColor(.white)
				.padding(.vertical)
			
			TextFieldView(title: "Name", text: $viewModel.name)
			
			TextFieldView(title: "Username", text: $viewModel.userName)
			
			Spacer()
			
		}
		.padding(.horizontal)
		.background(Color.app.background)
		.sheet(isPresented: $viewModel.isShowingImagePicker) {
			ImagePicker(image: $viewModel.image)
		}
	}
}

struct ProfileEditingView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileEditingView()
	}
}
