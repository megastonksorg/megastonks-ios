//
//  VerifySecretPhraseView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-29.
//

import SwiftUI
import IdentifiedCollections

struct VerifySecretPhraseView: View {
	@State var phraseInput: IdentifiedArrayOf<MnemonicWord>
	@State var phraseOptions: IdentifiedArrayOf<MnemonicWord>
	
	@State var currentSelection: UUID?
	@State var isContinueButtonDisabled: Bool = true
	
	var body: some View {
		VStack(spacing: 10) {
			Text("Verify your secret phrase to continue")
				.font(.app.subTitle)
				.foregroundColor(.white)
			
			Text("Tap an empty box to select it and fill it with one of the words below.")
				.font(.app.footer)
				.foregroundColor(.white)
			
			LazyVGrid(columns: Array(repeating: GridItem(), count: SizeConstants.phraseGridCount), spacing: SizeConstants.phraseGridSpacing) {
				ForEach(phraseInput) { input in
					MnemonicWordView(
						word: self.$phraseInput[id: input.id],
						viewHandler: {
							self.phraseInput.forEach { word in
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
							self.canUserContinue()
						}
					)
					.padding(.vertical, 10)
				}
			}
			
			Rectangle()
				.fill(Color.gray.opacity(0.4))
				.frame(height: 2)
			
			LazyVGrid(columns: Array(repeating: GridItem(), count: SizeConstants.phraseGridCount), spacing: SizeConstants.phraseGridSpacing) {
				ForEach(phraseOptions) { word in
					MnemonicWordView(
						word: self.$phraseOptions[id: word.id],
						viewHandler: {
							guard let currentSelection = currentSelection else {
								return
							}
							self.phraseInput[id: currentSelection]?.text = word.text
							self.phraseOptions.remove(id: word.id)
							self.currentSelection = nil
							self.canUserContinue()
						}
					)
					.padding(.vertical, 10)
				}
			}
			.padding(.bottom)
			
			Spacer()
			
			Button(action: {}) {
				Text("Continue")
					.fontWeight(.medium)
			}
			.buttonStyle(ExpandedButtonStyle(invertedStyle: false))
			.disabled(self.isContinueButtonDisabled)
		}
		.padding()
		.multilineTextAlignment(.center)
		.background(Color.app.background)
	}
	
	func canUserContinue() {
		self.isContinueButtonDisabled = !self.phraseOptions.isEmpty
	}
}

struct VerifySecretPhraseView_Previews: PreviewProvider {
	static var previews: some View {
		VerifySecretPhraseView(phraseInput: MnemonicPhrase.previewEmpty, phraseOptions: MnemonicPhrase.previewAlternateStyle)
	}
}
