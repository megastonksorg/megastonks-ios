//
//  VerifySecretPhraseVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-08-15.
//

import Combine
import Foundation
import IdentifiedCollections

extension VerifySecretPhraseView {
	@MainActor class ViewModel: ObservableObject {
		@Published var phraseInput: IdentifiedArrayOf<MnemonicWord>
		@Published var phraseOptions: IdentifiedArrayOf<MnemonicWord>
		
		@Published var currentSelection: UUID? = nil
		
		@Published var banner: BannerData?
		
		var isContinueButtonDisabled: Bool {
			self.phraseOptions.isEmpty
		}
		
		init() {
			self.phraseInput = MnemonicPhrase.empty
			switch WalletClient.shared.getMnemonic() {
				case .success(let mnemonic):
					self.phraseOptions = IdentifiedArrayOf(uniqueElements:
						mnemonic
							.split(separator: " ")
							.map {
								MnemonicWord(text: String($0), isSelectable: true, isAlternateStyle: true)
							}
					)
				case .failure(let error):
					self.phraseOptions = []
					self.banner = BannerData(title: error.title, detail: error.errorDescription ?? "", type: .error)
			}
		}
		
		func phraseInputSelected(input: MnemonicWord) {
			self.phraseInput.filter(\.isSelected).forEach { word in
				self.phraseInput[id: word.id]?.isSelected = false
			}
			if self.phraseInput[id: input.id]?.text.isEmpty ?? true {
				self.phraseInput[id: input.id]?.isSelected = true
				self.currentSelection = input.id
			}
			else {
				guard let text = self.phraseInput[id: input.id]?.text else { return }
				self.phraseOptions.append(MnemonicWord(text: text, isSelectable: true, isAlternateStyle: true))
				self.phraseInput[id: input.id]?.text = ""
				self.phraseInput[id: input.id]?.isSelected = true
				self.currentSelection = input.id
			}
		}
		
		func phraseOptionSelected(option: MnemonicWord) {
			guard let currentSelection = self.currentSelection else {
				return
			}
			self.phraseInput[id: currentSelection]?.text = option.text
			self.phraseOptions.remove(id: option.id)
			self.currentSelection = nil
		}
		
		func verifyMnemonicPhrase() {
			let input = self.phraseInput.map{ $0.text }.joined(separator: " ")
			
			switch WalletClient.shared.verifyMnemonic(mnemonic: input) {
				case .success(let walletAddress):
					AppRouter.pushStack(stack: .route1(.createProfile(walletAddress: walletAddress)))
					
				case .failure(let error):
					self.banner = BannerData(title: error.title, detail: error.errorDescription ?? "", type: .error)
			}
		}
	}
}
