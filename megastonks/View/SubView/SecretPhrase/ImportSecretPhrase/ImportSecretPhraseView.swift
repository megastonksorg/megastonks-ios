//
//  ImportSecretPhraseView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-10.
//

import SwiftUI

struct ImportSecretPhraseView: View {
	
	enum Field: Int, CaseIterable, Hashable, Identifiable {
		case one = 1
		case two = 2
		case three = 3
		case four = 4
		case five = 5
		case six = 6
		case seven = 7
		case eight = 8
		case nine = 9
		case ten = 10
		case eleven = 11
		case twelve = 12
		
		var id: Int {
			return self.rawValue
		}
	}
	
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
	
	@StateObject var viewModel: ViewModel = ViewModel()
		
	var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				Text("Type in your wallet phrase into each box to import it. You must type the phrase in the correct order for valid authentication")
					.font(.app.subTitle)
					.foregroundColor(.white)
					.multilineTextAlignment(.center)
					.padding(.bottom, 30)
				
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
						
						let isFocusedField: Bool = {
							return field == focusedField
						}()
						
						let cornerRadius: CGFloat = SizeConstants.wordCornerRadius
						let frame: CGSize = SizeConstants.wordSize
						let isWordReal: Bool = word.wrappedValue.isRealWord
						
						TextField(
							"",
							text: word,
							onCommit: { self.advanceToNextField() }
						)
						.foregroundColor(isWordReal ? .black : .white)
						.font(.system(.subheadline, weight: .bold))
						.multilineTextAlignment(.center)
						.minimumScaleFactor(0.6)
						.lineLimit(1)
						.focused($focusedField, equals: field)
						.padding(.horizontal, 4)
						.background {
							if isWordReal {
								RoundedRectangle(cornerRadius: cornerRadius)
									.fill(Color.megaStonksGreen)
									.frame(size: frame)
							}
							else {
								RoundedRectangle(cornerRadius: cornerRadius)
									.stroke(Color.gray.opacity(isFocusedField ? 1.0 : 0.5), lineWidth: 2)
									.frame(size: frame)
							}
						}
						.frame(size: frame)
						.padding(.vertical)
						.animation(.easeInOut, value: word.wrappedValue)
					}
				}
				
				Button(action: { self.resetWordFields() }) {
					Text("Tap to reset")
						.font(.app.footer)
						.fontWeight(.bold)
						.foregroundColor(.gray)
				}
			}
			.padding()
		}
		.safeAreaInset(edge: .bottom) {
			Button(action: {
				self.viewModel.popPath(route: .route1())
			}) {
				Text("Continue to Import")
			}
			.buttonStyle(ExpandedButtonStyle())
			//.disabled(!isContinueButtonEnabled())
			.padding()
			.padding(.bottom, 20)
		}
		.background(Color.app.background)
		.edgesIgnoringSafeArea(.bottom)
	}
	
	func advanceToNextField() {
		guard let currentField = self.focusedField?.rawValue else { return }
		if focusedField != .twelve {
			let nextField = Field(rawValue: currentField + 1)
			let shouldNavigate: Bool = {
				switch nextField {
					case .two: return self.word2.isEmpty
					case .three: return self.word3.isEmpty
					case .four: return self.word4.isEmpty
					case .five: return self.word5.isEmpty
					case .six: return self.word6.isEmpty
					case .seven: return self.word7.isEmpty
					case .eight: return self.word8.isEmpty
					case .nine: return self.word9.isEmpty
					case .ten: return self.word10.isEmpty
					case .eleven: return self.word11.isEmpty
					case .twelve: return self.word12.isEmpty
					default: return false
				}
			}()
			if shouldNavigate { self.focusedField = nextField }
		}
	}
	
	func isContinueButtonEnabled() -> Bool {
		return word1.isRealWord && word2.isRealWord && word3.isRealWord
		&& word4.isRealWord && word5.isRealWord && word6.isRealWord
		&& word7.isRealWord && word8.isRealWord && word9.isRealWord
		&& word10.isRealWord && word11.isRealWord && word12.isRealWord
	}
	
	func resetWordFields() {
		self.word1 = ""
		self.word2 = ""
		self.word3 = ""
		self.word4 = ""
		self.word5 = ""
		self.word6 = ""
		self.word7 = ""
		self.word8 = ""
		self.word9 = ""
		self.word10 = ""
		self.word11 = ""
		self.word12 = ""
	}
}

struct ImportSecretPhraseView_Previews: PreviewProvider {
	static var previews: some View {
		ImportSecretPhraseView()
	}
}
