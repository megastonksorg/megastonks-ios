//
//  SecretPhraseView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-28.
//

import SwiftUI

struct SecretPhraseView: View {
	let phrase: [MnemonicWord]
	
	var body: some View {
		VStack(spacing: 20) {
            Spacer()
            
			Text("Secret recovery phrase")
				.font(.app.title)
				.foregroundColor(.white)
			
			Text("This is the only way you will be able to recover your account. Please store or write it down somewhere safe")
				.font(.app.subTitle)
				.foregroundColor(.gray)
				.padding(.horizontal)
			
            LazyVGrid(columns: Array(repeating: GridItem(), count: SizeConstants.phraseGridCount), spacing: SizeConstants.phraseGridSpacing) {
				ForEach(phrase){ word in
					MnemonicWordView(word: word, viewHandler: {print(phrase.count)})
						.padding(.vertical)
				}
			}
			.padding(.horizontal, 4)
            
            Button(action: {} ) {
                HStack {
                    Spacer()
                    Image(systemName: "doc.on.doc.fill")
                    Text("Copy to clipboard")
                    Spacer()
                }
                .font(.app.subTitle)
                .foregroundColor(.white)
                .padding(.vertical)
            }
            
            Spacer()
            
            Text("You won’t be able to contiune to the next step unless you have clicked ‘Copy to clipboard’ above. This is our way to make sure you have saved the phrase.")
                .font(.app.footer)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Button(action: {}) {
                Text("I saved it somewhere safe")
                    .fontWeight(.medium)
            }
            .buttonStyle(ExpandedButtonStyle(invertedStyle: true))
		}
        .padding()
		.multilineTextAlignment(.center)
		.background(Color.app.background)
	}
}

struct SecretPhraseView_Previews: PreviewProvider {
	static var previews: some View {
        SecretPhraseView(phrase: MnemonicPhrase.preview)
	}
}
