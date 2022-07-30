//
//  AuthenticateVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-30.
//

import Combine

extension AuthenticateView {
	@MainActor class ViewModel: ObservableObject {
		@Published var user: User
		
		init(user: User) {
			self.user = user
		}
	}
}
