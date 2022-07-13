//
//  TextFieldView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-13.
//

import SwiftUI

struct TextFieldView: View {
	
	let title: String
	@Binding var text: String
	@Binding var validation: FieldValidation
	
	init(title: String,
		 text: Binding<String>,
		 validation: Binding<FieldValidation> = Binding.constant(FieldValidation.unknown)
	) {
		self.title = title
		self._text = text
		self._validation = validation
	}
	
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 4) {
				Text(title)
					.font(.system(.footnote, weight: .light))
					.foregroundColor(.white)
				TextField("", text: $text)
					.font(.system(size: 15, weight: .semibold))
					.foregroundColor(.white)
			}
			Group {
				switch self.validation {
					case .valid: Image(systemName: "checkmark.circle.fill").foregroundColor(.megaStonksGreen)
					case .invalid: Image(systemName: "xmark.circle.fill").foregroundColor(.megaStonksRed)
					case .unknown: EmptyView()
				}
			}
		}
		.padding(10)
		.background (
			RoundedRectangle(cornerRadius: SizeConstants.cornerRadius)
				.stroke(Color.megaStonksGray2, lineWidth: 1)
				.overlay(
					RoundedRectangle(cornerRadius: SizeConstants.cornerRadius)
						.fill(Color.megaStonksGray)
				)
		)
	}
}

struct TextFieldView_Previews: PreviewProvider {
	static var previews: some View {
		TextFieldView(title: "Name", text: Binding.constant(""), validation: Binding.constant(.valid))
	}
}
