//
//  AppRouter.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-16.
//

import Foundation

@MainActor class AppRouter: ObservableObject {
	enum Route: Hashable {
		enum Stack1: Hashable {
			case createWallet
			case importWallet
			case createProfile
		}
		enum Stack2: Hashable {
		}
		
		case route1(Stack1? = nil)
		case route2(Stack2? = nil)
	}
	
	@Published var stack1: [Route.Stack1] = []
	@Published var stack2: [Route.Stack2] = []
	
	func pushPath(route: Route) {
		switch route {
		case .route1(let route):
			if let route = route { self.stack1.append(route) }
		case .route2(let route):
			if let route = route { self.stack2.append(route) }
		}
	}
	
	func popPath(route: Route) {
		switch route {
		case .route1: self.stack1.removeLast()
		case .route2: self.stack2.removeLast()
		}
	}
	
	func popToRoot(route: Route) {
		switch route {
		case .route1: self.stack1 = []
		case .route2: self.stack2 = []
		}
	}
}
