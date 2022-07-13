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
		
		@Published var isShowingImagePicker: Bool = false
		
		var nameValidation: FieldValidation {
			if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return .unknown }
			else {
				if name.trimmingCharacters(in: .whitespacesAndNewlines).isValidName { return .valid }
				else { return .invalid }
			}
		}
		
		var userNameValidation: FieldValidation {
			if userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return .unknown }
			else {
				if userName.trimmingCharacters(in: .whitespacesAndNewlines).isValidUserName { return .valid }
				else { return .invalid }
			}
		}
		
		init() {}
		
		func selectImageFromLibrary() {
			self.isShowingImagePicker = true
		}
	}
}
