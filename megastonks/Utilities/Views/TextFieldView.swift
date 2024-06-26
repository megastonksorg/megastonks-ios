//
//  TextFieldView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import SwiftUI

struct TextFieldView: View {
	
	let title: String
	let validation: FieldValidation
	let submitLabel: SubmitLabel
	let onCommit: () -> ()
	@Binding var text: String
	
	init(title: String,
		 validation: FieldValidation = FieldValidation.unknown,
		 submitLabel: SubmitLabel = .return,
		 onCommit: @escaping () -> () = {},
		 text: Binding<String>
	) {
		self.title = title
		self.validation = validation
		self.submitLabel = submitLabel
		self.onCommit = onCommit
		self._text = text
	}
	
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 4) {
				Text(title)
					.font(.system(.footnote, weight: .light))
					.foregroundColor(.white)
				TextField("", text: $text, onCommit: { onCommit() })
					.font(.system(size: 15, weight: .semibold))
					.foregroundColor(.white)
					.submitLabel(submitLabel)
			}
			Group {
				switch self.validation {
					case .valid: Image(systemName: "checkmark.circle.fill").foregroundColor(.app.green)
					case .invalid: Image(systemName: "xmark.circle.fill").foregroundColor(.app.red)
					case .unknown: EmptyView()
				}
			}
		}
		.padding(10)
		.background(TextFieldBackgroundView())
	}
}

struct TextFieldView_Previews: PreviewProvider {
	static var previews: some View {
		TextFieldView(title: "Name", validation: .unknown, text: Binding.constant(""))
	}
}
