//
//  ContentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

struct AppView: View {
	var body: some View {
		MnemonicPhraseView(phrase: Array(repeating: MnemonicWord(text: "boy", isSelectable: true, isAlternateStyle: false), count: 12))
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
