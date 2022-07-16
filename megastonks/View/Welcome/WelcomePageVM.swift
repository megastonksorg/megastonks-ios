//
//  WelcomePageVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-14.
//

import Foundation

extension WelcomePageView {
	@MainActor class ViewModel: AppRouter {
		
		let walletClient: WalletClient = WalletClient.shared
		
		private var hasGeneratedWallet: Bool = false
		
		@Published var isLoading: Bool = false
		
		@Published var banner: BannerData?
		
		func generateNewWallet() {
			self.isLoading = true
			if !self.hasGeneratedWallet {
				switch walletClient.generateNewWallet() {
				case .success(let wallet):
					self.hasGeneratedWallet = true
					walletClient.saveMnemonic(mnemonic: wallet.mnemonic)
					self.pushPath(route: .route1(.createWallet))
				case .failure(let error):
					self.banner = BannerData(title: error.title, detail: error.localizedDescription, type: .error)
				}
			}
			else {
				self.pushPath(route: .route1(.createWallet))
			}
			self.isLoading = false
		}
	}
}
