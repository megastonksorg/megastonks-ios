//
//  ProfileEditingViewModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import Combine
import UIKit

extension ProfileEditingView {
	@MainActor class ViewModel: ObservableObject {
		@Published var image: UIImage?
		@Published var name: String = ""
		@Published var userName: String = ""
		@Published var nameValidation: FieldValidation = .unknown
		@Published var usernameValidation: FieldValidation = .unknown
		
		@Published var isShowingImagePicker: Bool = false
		
		init() {}
		
		func selectImageFromLibrary() {
			self.isShowingImagePicker = true
		}
	}
}
