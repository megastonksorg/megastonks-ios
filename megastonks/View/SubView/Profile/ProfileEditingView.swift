//
//  ProfileEditingView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import SwiftUI

struct ProfileEditingView: View {
	
	@StateObject private var viewModel: ViewModel
	@FocusState private var focusField: ViewModel.FocusField?
	
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
										.clipShape(Circle())
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
			
			TextFieldView(
				title: "Name",
				validation: viewModel.nameValidation,
				onCommit: { self.focusField = .userName },
				text: $viewModel.name
			)
			.focused(self.$focusField, equals: .name)
			
			TextFieldView(title: "Username", validation: viewModel.userNameValidation, text: $viewModel.userName)
				.focused(self.$focusField, equals: .userName)
			
			Spacer()
			
		}
		.padding(.horizontal)
		.background(Color.app.background)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Image(systemName: "arrow.left")
			}
			ToolbarItem(placement: .principal) {
				Text("Profile")
					.fontWeight(.bold)
			}
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {}) {
					Text("Done")
						.foregroundColor(.white)
				}
			}
		}
		.sheet(isPresented: $viewModel.isShowingImagePicker) {
			ImagePicker(image: $viewModel.image)
		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
				self.focusField = .name
			}
		}
	}
}

struct ProfileEditingView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileEditingView()
	}
}
