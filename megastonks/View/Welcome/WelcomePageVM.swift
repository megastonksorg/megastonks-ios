//
//  WelcomePageVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-14.
//

import Foundation

extension WelcomePageView {
	@MainActor class ViewModel: ObservableObject {
		enum Route: Hashable {
			case createWallet
			case importWallet
		}
		
		let walletClient: WalletClient = WalletClient.shared
		
		private var hasGeneratedWallet: Bool = false
		
		@Published var isLoading: Bool = false
		
		@Published var path: [Route] = []
		@Published var banner: BannerData?
		
		func generateNewWallet() {
			self.isLoading = true
			if !self.hasGeneratedWallet {
				switch walletClient.generateNewWallet() {
				case .success(let wallet):
					self.hasGeneratedWallet = true
					walletClient.saveMnemonic(mnemonic: wallet.mnemonic)
					pushPath(route: .createWallet)
				case .failure(let error):
					self.banner = BannerData(title: error.title, detail: error.localizedDescription, type: .error)
				}
			}
			else {
				pushPath(route: .createWallet)
			}
			self.isLoading = false
		}
		
		func pushPath(route: Route) {
			path.append(route)
		}
		
		func popPath() {
			path.removeLast()
		}
		
		func popToRoot() {
			path = []
		}
	}
}
