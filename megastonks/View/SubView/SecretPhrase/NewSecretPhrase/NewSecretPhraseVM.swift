//
//  NewSecretPhraseVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-14.
//

import Combine
import SwiftUI
import IdentifiedCollections

extension NewSecretPhraseView {
	@MainActor class ViewModel: ObservableObject {
		
		var walletAddress: String?
		
		@Published var isShowingTerms: Bool = false
		@Published var didUserAcceptTerms: Bool = false
		@Published var phrase: IdentifiedArrayOf<MnemonicWord> = []
		
		@Published var banner: BannerData?
		
		init() {
			switch WalletClient.shared.getMnemonic() {
			case .success(let mnemonic):
				let mnemonicWords: [MnemonicWord] =
				mnemonic.split(separator: " ").map{ MnemonicWord(text: String($0), isSelectable: false, isAlternateStyle: false) }
	
				let walletResult = WalletClient.shared.importWallet(mnemonic: mnemonic)
					switch walletResult {
						case .success(let hdWallet):
							self.walletAddress = hdWallet.getAddressForCoin(coin: .ethereum)
							self.phrase = IdentifiedArray(uniqueElements: mnemonicWords)
						case .failure(let error):
							self.banner = BannerData(title: error.title, detail: error.errorDescription ?? "", type: .error)
					}
				case .failure(let error):
					self.banner = BannerData(title: error.title, detail: error.errorDescription ?? "", type: .error)
			}
		}
		
		func openTerms() { self.isShowingTerms = true }
		
		func didDismissTerms() {
			if !didUserAcceptTerms {
				withAnimation(.easeIn) {
					self.didUserAcceptTerms = true
				}
			}
		}
		
		func createProfile() {
			guard let walletAddress = self.walletAddress else { return }
			AppRouter.pushStack(stack: .route1(.createProfile(walletAddress: walletAddress)))
		}
	}
}
