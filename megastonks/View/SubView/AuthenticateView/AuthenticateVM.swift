//
//  AuthenticateVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-30.
//

import Combine

extension AuthenticateView {
	@MainActor class ViewModel: ObservableObject {
		@Published var user: User
		
		@Published var banner: BannerData?
		
		init(user: User) {
			self.user = user
		}
		
		func copyAddress() {
			PasteboardClient.shared.copyText(user.walletAddress)
			banner = BannerData(detail: "Address copied to clipboard", type: .success)
		}
		
		func cancel() {
			
		}
		
		func authenticate() {
			
		}
	}
}
