//
//  NewSecretPhraseVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-14.
//

import Combine
import SwiftUI

extension NewSecretPhraseView {
	@MainActor class ViewModel: ObservableObject {
		@Published var isShowingTerms: Bool = false
		@Published var didUserAcceptTerms: Bool = false
		
		func openTerms() { self.isShowingTerms = true }
		
		func didDismissTerms() {
			if !didUserAcceptTerms {
				withAnimation(.easeIn) {
					self.didUserAcceptTerms = true
				}
			}
		}
	}
}
