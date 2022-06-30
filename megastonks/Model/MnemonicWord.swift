//
//  MnemonicWord.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-28.
//

import Foundation

struct MnemonicWord: Identifiable {
	let text: String
	var isSelected: Bool = false
	let isSelectable: Bool
	let isAlternateStyle: Bool
}

extension MnemonicWord {
	var id: String { text }
	var isEmpty: Bool { text.isEmpty }
}

struct MnemonicPhrase {
    var phrase: [MnemonicWord]
    
	static var preview: [MnemonicWord] = {
		[
			MnemonicWord(text: "boy", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "girl", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "shoe", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "can", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "baby", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "geez", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "bad", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "rain", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "trouble", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "uncanny", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "journey", isSelectable: false, isAlternateStyle: false),
			MnemonicWord(text: "look", isSelectable: false, isAlternateStyle: false),
		]
	}()
}
