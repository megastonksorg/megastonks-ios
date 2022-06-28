//
//  MnemonicWord.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-28.
//

import Foundation

struct MnemonicWord {
	let text: String
	var isSelected: Bool = false
	let isSelectable: Bool
	let isAlternateStyle: Bool
}

extension MnemonicWord {
	var isEmpty: Bool { text.isEmpty }
}
