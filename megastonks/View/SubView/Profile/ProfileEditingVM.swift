//
//  ProfileEditingViewModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import Combine
import SwiftUI

extension ProfileEditingView {
	@MainActor class ViewModel: ObservableObject {
		
		//MARK: - Subtypes
		enum FocusField {
			case name
			case userName
		}
		
		let apiClient: APIClient = APIClient.shared
		
		private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
		
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
		
		func uploadImage() {
			guard let image = self.image,
				  let resizedImage = image.resizedTo(megaBytes: 2.0),
				  let croppedImageData = resizedImage.croppedAndScaled(toFill: SizeConstants.profileImageSize).pngData() else { return }
			apiClient.uploadImage(imageData: croppedImageData)
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: { completion in
					switch completion {
						case .finished: return
						case .failure(let error):
							print("UPLOAD: \(error.title) \(error.errorDescription ?? "")")
					}
				}, receiveValue: { url in
					print("UPLOAD: \(String(describing: url))")
				})
				.store(in: &cancellables)
		}
	}
}
