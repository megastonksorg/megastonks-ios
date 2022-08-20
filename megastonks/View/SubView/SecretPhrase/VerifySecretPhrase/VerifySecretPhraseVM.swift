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
		
		@Published var currentSelection: UUID?
		
		var isContinueButtonDisabled: Bool {
			self.phraseOptions.isEmpty
		}
		
		init(phraseInput: IdentifiedArrayOf<MnemonicWord>, phraseOptions: IdentifiedArrayOf<MnemonicWord>, currentSelection: UUID? = nil) {
			self.phraseInput = phraseInput
			self.phraseOptions = phraseOptions
			self.currentSelection = currentSelection
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
			
		}
	}
}
