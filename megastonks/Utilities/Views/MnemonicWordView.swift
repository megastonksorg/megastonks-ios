//
//  MnemonicTextView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-27.
//

import SwiftUI

struct MnemonicWordView: View {
	var word: MnemonicWord
	var viewHandler: (() -> Void)
	
	var body: some View {
		Button(action: { viewHandler() }) {
			buttonLabel()
		}
		.buttonStyle(AnimatedButtonStyle())
		.disabled(!word.isSelectable)
	}
	
	@ViewBuilder
	func buttonLabel() -> some View {
		let size = SizeConstants.wordSize
		let cornerRadius: CGFloat = 5.0
		let textColor: Color = word.isAlternateStyle ? .white : .black
		if word.isEmpty {
			RoundedRectangle(cornerRadius: cornerRadius)
				.stroke(
					word.isSelected ? Color.megaStonksGreen : Color.white.opacity(0.6),
					style: StrokeStyle(
						lineWidth: 1,
						lineCap: .round,
						lineJoin: .miter,
						miterLimit: 4,
						dash: [4],
						dashPhase: 4
					)
				)
				.frame(size: size)
		}
		else {
			Text(word.text)
				.font(.subheadline)
				.bold()
				.foregroundColor(textColor)
				.minimumScaleFactor(0.6)
				.lineLimit(1)
				.background {
					if word.isAlternateStyle {
						RoundedRectangle(cornerRadius: cornerRadius)
							.stroke(Color.white, lineWidth: 2)
							.frame(size: size)
					}
					else {
						RoundedRectangle(cornerRadius: cornerRadius)
							.fill(Color.megaStonksGreen)
							.frame(size: size)
					}
				}
		}
	}
}

struct MnemonicWordView_Previews: PreviewProvider {
	static var previews: some View {
		MnemonicWordView(word: MnemonicWord(text: "", isSelectable: true, isAlternateStyle: false), viewHandler: {})
			.preferredColorScheme(.dark)
	}
}
