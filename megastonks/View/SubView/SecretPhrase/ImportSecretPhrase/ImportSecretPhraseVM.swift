//
//  ImportSecretPhraseVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-16.
//

import Foundation

extension ImportSecretPhraseView {
	@MainActor class ViewModel: ObservableObject {
		
		func pushView() {
			AppRouter.pushStack(stack: .route1(.importWallet))
		}
	}
}
