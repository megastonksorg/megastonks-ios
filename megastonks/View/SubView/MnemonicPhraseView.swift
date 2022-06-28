//
//  MnemonicPhraseView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-28.
//

import SwiftUI

struct MnemonicPhraseView: View {
	let phrase: [MnemonicWord]
	
	var body: some View {
		VStack(spacing: 10) {
			Text("Secret recovery phrase")
				.font(.app.title)
				.foregroundColor(.white)
			
			Text("This is the only way you will be able to recover your account. Please store or write it down somewhere safe")
				.font(.app.subTitle)
				.foregroundColor(.gray)
				.padding(.horizontal)
			
			LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
				ForEach(phrase){ word in
					MnemonicWordView(word: word, viewHandler: {print(phrase.count)})
						.padding(.vertical)
				}
			}
			.padding(.horizontal, 4)
		}
		.multilineTextAlignment(.center)
		.pushOutFrame()
		.background(Color.app.background)
	}
}

struct MnemonicPhraseView_Previews: PreviewProvider {
	static var previews: some View {
		MnemonicPhraseView(phrase: MnemonicPhrase.preview)
	}
}
