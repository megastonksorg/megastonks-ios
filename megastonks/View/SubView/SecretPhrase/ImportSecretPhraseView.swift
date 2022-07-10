//
//  ImportSecretPhraseView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-10.
//

import SwiftUI

struct ImportSecretPhraseView: View {
	
	enum Field: String, CaseIterable, Hashable, Identifiable {
		case one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve
		
		var id: String {
			return self.rawValue
		}
	}
	
	let fieldSize = SizeConstants.wordSize
	
	@State private var word1: String = ""
	@State private var word2: String = ""
	@State private var word3: String = ""
	@State private var word4: String = ""
	@State private var word5: String = ""
	@State private var word6: String = ""
	@State private var word7: String = ""
	@State private var word8: String = ""
	@State private var word9: String = ""
	@State private var word10: String = ""
	@State private var word11: String = ""
	@State private var word12: String = ""
	
	@FocusState private var focusedField: Field?
	
	var body: some View {
		VStack(spacing: 20) {
			Text("Type in your wallet phrase into each box to import it. You must type the phrase in the correct order for valid authentication")
				.font(.app.subTitle)
				.foregroundColor(.white)
				.multilineTextAlignment(.center)
				.padding(.vertical, 30)
			
			LazyVGrid(columns: Array(repeating: GridItem(), count: SizeConstants.phraseGridCount), spacing: SizeConstants.phraseGridSpacing) {
				ForEach(Field.allCases) { field in
					let word: Binding<String> = {
						switch field {
						case .one: return $word1
						case .two: return $word2
						case .three: return $word3
						case .four: return $word4
						case .five: return $word5
						case .six: return $word6
						case .seven: return $word7
						case .eight: return $word8
						case .nine: return $word9
						case .ten: return $word10
						case .eleven: return $word11
						case .twelve: return $word12
						}
					}()
					
					TextField("", text: word)
						.foregroundColor(.black)
						.font(.system(.subheadline, weight: .bold))
						.multilineTextAlignment(.center)
						.minimumScaleFactor(0.6)
						.lineLimit(1)
						.focused($focusedField, equals: field)
						.padding(.horizontal, 4)
						.background(
							RoundedRectangle(cornerRadius: SizeConstants.wordCornerRadius)
								.fill(Color.megaStonksGreen)
								.frame(size: fieldSize)
						)
						.frame(size: fieldSize)
						.padding(.vertical)
				}
			}
			
			Spacer()
		}
		.background(Color.app.background)
	}
}

struct ImportSecretPhraseView_Previews: PreviewProvider {
	static var previews: some View {
		ImportSecretPhraseView()
	}
}
