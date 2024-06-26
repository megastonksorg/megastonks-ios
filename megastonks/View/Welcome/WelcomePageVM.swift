//
//  WelcomePageVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-14.
//

import Foundation
import Combine

extension WelcomePageView {
	@MainActor class ViewModel: ObservableObject {
		
		//Clients
		let walletClient = WalletClient.shared
		
		private var hasGeneratedWallet: Bool = false
		private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
		
		@Published var isLoading: Bool = false
		
		@Published var banner: BannerData?
		
		func generateNewWallet() {
			self.isLoading = true
			if !self.hasGeneratedWallet {
				switch self.walletClient.generateNewWallet() {
				case .success(let wallet):
					self.hasGeneratedWallet = true
						self.walletClient.saveMnemonic(mnemonic: wallet.mnemonic)
						AppRouter.pushStack(stack: .route1(.createWallet))
				case .failure(let error):
					self.banner = BannerData(title: error.title, detail: error.localizedDescription, type: .error)
				}
			}
			else {
				AppRouter.pushStack(stack: .route1(.createWallet))
			}
			self.isLoading = false
		}
		
		func importWallet() {
			AppRouter.pushStack(stack: .route1(.importWallet))
		}
	}
}
