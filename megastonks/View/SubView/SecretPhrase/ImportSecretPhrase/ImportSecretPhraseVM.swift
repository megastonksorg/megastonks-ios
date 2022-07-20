//
//  ImportSecretPhraseVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-16.
//

import Foundation

extension ImportSecretPhraseView {
	@MainActor class ViewModel: ObservableObject {
		
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
		
		@Published var word1: String = ""
		@Published var word2: String = ""
		@Published var word3: String = ""
		@Published var word4: String = ""
		@Published var word5: String = ""
		@Published var word6: String = ""
		@Published var word7: String = ""
		@Published var word8: String = ""
		@Published var word9: String = ""
		@Published var word10: String = ""
		@Published var word11: String = ""
		@Published var word12: String = ""
		
		@Published var focusedField: Field?
		
		func advanceToNextField() {
			guard let currentField = self.focusedField?.rawValue else { return }
			if self.focusedField != .twelve {
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
		
		func isContinueButtonEnabled() -> Bool {
			return self.word1.isRealWord && self.word2.isRealWord && self.word3.isRealWord
			&& self.word4.isRealWord && self.word5.isRealWord && self.word6.isRealWord
			&& self.word7.isRealWord && self.word8.isRealWord && self.word9.isRealWord
			&& self.word10.isRealWord && self.word11.isRealWord && self.word12.isRealWord
		}
		
		func pushView() {
			AppRouter.pushStack(stack: .route1(.importWallet))
		}
	}
}
