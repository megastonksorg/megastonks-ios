//
//  WelcomePageVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-14.
//

import Combine

extension WelcomePageView {
	@MainActor class ViewModel: ObservableObject {
		enum Route: Hashable {
			case createWallet
			case importWallet
		}
		
		let walletClient: WalletClient = WalletClient.shared
		
		@Published var isLoading: Bool = false
		
		@Published var path: [Route] = []
		@Published var banner: BannerData?
		
		func generateNewWallet() {
			self.isLoading = true
			switch walletClient.generateNewWallet() {
			case .success(let wallet):
				walletClient.saveMnemonic(mnemonic: wallet.mnemonic)
				pushPath(route: .createWallet)
			case .failure(let error):
				self.banner = BannerData(title: error.title, detail: error.localizedDescription, type: .error)
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
