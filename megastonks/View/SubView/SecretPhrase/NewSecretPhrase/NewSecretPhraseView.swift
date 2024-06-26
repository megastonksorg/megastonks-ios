//
//  NewSecretPhraseView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-28.
//

import SwiftUI
import IdentifiedCollections

struct NewSecretPhraseView: View {
	
	@StateObject var viewModel: ViewModel = ViewModel()
	
	@EnvironmentObject var appRouter: AppRouter
	
	var body: some View {
		VStack(spacing: 20) {
			if viewModel.phrase.isEmpty {
				Text("Could not retrieve mnemonic phrase.\nPlease try that again.")
					.font(.title2)
					.foregroundColor(.white)
					.pushOutFrame()
			}
			else {
				let didUserAcceptTerms = viewModel.didUserAcceptTerms
				
				Spacer(minLength: 0)
				
				Text("Secret recovery phrase")
					.font(.app.title)
					.foregroundColor(.white)
				
				Text("This is the only way you will be able to recover your account. Please store or write it down somewhere safe")
					.font(.app.subTitle)
					.foregroundColor(.gray)
					.padding(.horizontal)
				
				LazyVGrid(columns: Array(repeating: GridItem(), count: SizeConstants.phraseGridCount), spacing: SizeConstants.phraseGridSpacing) {
					ForEach(viewModel.phrase){ word in
						MnemonicWordView(word: $viewModel.phrase[id: word.id])
							.padding(.vertical)
					}
				}
				.padding(.horizontal, 4)
				
				Spacer(minLength: 0)
				
				Button(action: { viewModel.openTerms() } ) {
					HStack {
						Spacer()
						Image(systemName: didUserAcceptTerms ? "checkmark.square.fill" : "square")
						Text(didUserAcceptTerms ? "Terms Accepted" : "Accept Terms To Proceed")
						Spacer()
					}
					.font(.app.subTitle)
					.foregroundColor(.white)
					.opacity(0.6)
				}
				
				Spacer(minLength: 0)
				
				Text("You won’t be able to continue past the next step if you are unable to verify this phrase. Please memorize it or write it down on a piece of paper and store it in a secure location.")
					.font(.app.footer)
					.foregroundColor(.gray)
					.multilineTextAlignment(.center)
				
				Button(action: { viewModel.verifyMnemonicPhrase() }) {
					Text("I saved it somewhere safe")
						.fontWeight(.medium)
				}
				.buttonStyle(ExpandedButtonStyle(invertedStyle: false))
				.disabled(!didUserAcceptTerms)
			}
		}
		.padding()
		.multilineTextAlignment(.center)
		.background(Color.app.background)
		.sheet(
			isPresented: $viewModel.isShowingTerms,
			onDismiss: { viewModel.didDismissTerms() }
		) {
			TermsAndConditionsView()
		}
	}
}

struct NewSecretPhraseView_Previews: PreviewProvider {
	static var previews: some View {
		NewSecretPhraseView()
	}
}
