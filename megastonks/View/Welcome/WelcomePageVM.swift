//
//  WelcomePageVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-14.
//

import Combine

extension WelcomePageView {
	@MainActor class ViewModel: ObservableObject {
		enum Route: Hashable {
			case createWallet
			case importWallet
		}
		
		@Published var path: [Route] = []
		
		func pushPath(route: Route) {
			path.append(route)
		}
		
		func popPath() {
			path.removeLast()
		}
		
		func popToRoot() {
			path = []
		}
	}
}
