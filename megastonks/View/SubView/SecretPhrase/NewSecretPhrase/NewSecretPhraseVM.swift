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
		
		let walletClient: WalletClient = WalletClient.shared
		
		@Published var isShowingTerms: Bool = false
		@Published var didUserAcceptTerms: Bool = false
		@Published var phrase: IdentifiedArrayOf<MnemonicWord> = []
		
		@Published var banner: BannerData?
		
		init() {
			switch walletClient.getMnemonic() {
			case .success(let mnemonic):
				let mnemonicWords: [MnemonicWord] =
				mnemonic.split(separator: " ").map{ MnemonicWord(text: String($0), isSelectable: false, isAlternateStyle: false) }
				
				self.phrase = IdentifiedArray(uniqueElements: mnemonicWords)
			default: return
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
			AppRouter.pushStack(stack: .route1(.createProfile))
		}
	}
}
