//
//  VerifySecretPhraseView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-29.
//

import SwiftUI

struct VerifySecretPhraseView: View {
    @State var phraseInput: [MnemonicWord]
    @State var phraseOptions: [MnemonicWord]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Verify your secret phrase to continue")
                .font(.app.subTitle)
                .foregroundColor(.white)
            
            Text("Tap an empty box to select it and fill it with one of the words below.")
                .font(.app.footer)
                .foregroundColor(.white)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: SizeConstants.phraseGridCount), spacing: SizeConstants.phraseGridSpacing) {
                ForEach(phraseInput) { word in
                    MnemonicWordView(word: word, viewHandler: { })
                        .padding(.vertical, 10)
                }
            }
            
            Divider()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: SizeConstants.phraseGridCount), spacing: SizeConstants.phraseGridSpacing) {
                ForEach(phraseOptions) { word in
                    MnemonicWordView(word: word, viewHandler: {})
                        .padding(.vertical, 10)
                }
            }
            .padding(.bottom)
            
            Button(action: {}) {
                Text("Continue")
                    .fontWeight(.medium)
            }
            .buttonStyle(ExpandedButtonStyle(invertedStyle: true))
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(Color.app.background)
    }
}

struct VerifySecretPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        VerifySecretPhraseView(phraseInput: MnemonicPhrase.previewEmpty, phraseOptions: MnemonicPhrase.previewAlternateStyle)
    }
}
