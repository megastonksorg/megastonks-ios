//
//  ProfileSettingsViewModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import Combine
import SwiftUI

extension ProfileSettingsView {
	@MainActor class ViewModel: ObservableObject {
		
		//MARK: - Subtypes
		enum Mode {
			case creation
			case editing
		}
		
		enum FocusField {
			case name
			case userName
		}
		
		let mode: ProfileSettingsView.ViewModel.Mode
		
		var walletAddress: String?
		var user: User?
		
		private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
		
		@Published var image: UIImage?
		@Published var name: String = ""
		@Published var userName: String = ""
		
		@Published var isShowingImagePicker: Bool = false
		@Published var isLoading: Bool = false
		
		@Published var banner: BannerData?
		
		var profilePictureTitle: String {
			switch self.mode {
				case .creation: return "Select a profile picture"
				case .editing: return "Change your profile picture"
			}
		}
		
		var buttonTitle: String {
			switch self.mode {
				case .creation: return "Create User"
				case .editing: return "Update User"
			}
		}
		
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
		
		init(
			mode: ProfileSettingsView.ViewModel.Mode,
			walletAddress: String? = nil,
			user: User? = nil
		) {
			self.mode = mode
			self.walletAddress = walletAddress
			self.user = user
			
			if let user = user {
				self.name = user.fullName
				self.userName = user.userName
			}
		}
		
		func selectImageFromLibrary() {
			self.isShowingImagePicker = true
		}
		
		func complete() {
			switch self.mode {
				case .editing: return
				case .creation:
					if walletAddress == nil {
						self.banner = BannerData(detail: "Cannot Create user without a valid wallet", type: .warning)
					}
					guard let walletAddress = self.walletAddress,
						  let image = self.image,
						  let resizedImage = image.resizedTo(megaBytes: 2.0),
						  let croppedImageData = resizedImage.croppedAndScaled(toFill: SizeConstants.profileImageSize).pngData() else { return }

					APIClient.shared.uploadImage(imageData: croppedImageData)
						.flatMap { url -> AnyPublisher<RegisterResponse, APIClientError>  in
							let registerRequestModel: RegisterRequest = RegisterRequest(
								walletAddress: walletAddress,
								profilePhoto: url,
								fullName: self.name,
								userName: self.userName
							)

							return APIClient.shared.registerUser(model: registerRequestModel)
						}
						.receive(on: DispatchQueue.main)
						.sink(receiveCompletion: { [weak self] completion in
							guard let self = self else { return }
							switch completion {
								case .finished: return
								case .failure(let error):
									self.banner = BannerData(title: error.title, detail: error.errorDescription ?? "", type: .error)
							}
						}, receiveValue: { registerResponse in
							let user: User = User(
								walletAddress: registerResponse.walletAddress,
								fullName: registerResponse.fullName,
								userName: registerResponse.userName,
								profilePhoto: registerResponse.profilePhoto,
								currency: registerResponse.currency,
								acceptTerms: registerResponse.acceptTerms,
								isOnboarded: registerResponse.isOnboarded
							)
						})
						.store(in: &cancellables)
			}
		}
	}
}
