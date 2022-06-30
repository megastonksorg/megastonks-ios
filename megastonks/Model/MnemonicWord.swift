//
//  MnemonicWord.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-28.
//

import Foundation

struct MnemonicWord: Identifiable {
    let id: UUID = UUID()
	let text: String
	var isSelected: Bool = false
	let isSelectable: Bool
	let isAlternateStyle: Bool
}

extension MnemonicWord {
	var isEmpty: Bool { text.isEmpty }
}

struct MnemonicPhrase {
    var phrase: [MnemonicWord]
    
	static var preview: [MnemonicWord] = {
		[
			MnemonicWord(text: "boy", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "girl", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "shoe", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "can", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "baby", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "geez", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "bad", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "rain", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "trouble", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "uncanny", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "journey", isSelectable: true, isAlternateStyle: false),
			MnemonicWord(text: "look", isSelectable: true, isAlternateStyle: false),
		]
	}()
    
    static var previewAlternateStyle: [MnemonicWord] = {
        [
            MnemonicWord(text: "boy", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "girl", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "shoe", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "can", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "baby", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "geez", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "bad", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "rain", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "trouble", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "uncanny", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "journey", isSelectable: true, isAlternateStyle: true),
            MnemonicWord(text: "look", isSelectable: true, isAlternateStyle: true),
        ]
    }()
    
    static var previewEmpty: [MnemonicWord] = {
        [
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
            MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false),
        ]
    }()
}
