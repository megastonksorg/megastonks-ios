//
//  Notification+Name.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-19.
//

import Foundation

let stackKeyNotification: String = "stack"

extension Notification.Name {
	static let pushStack = Notification.Name("pushStack")
	static let popStack = Notification.Name("popStack")
}

extension Notification {
	static func pushStack(stack: AppRouter.Route) -> Notification {
		Notification(name: .pushStack, userInfo: [stackKeyNotification: stack])
	}
	
	static func popStack(stack: AppRouter.Route) -> Notification {
		Notification(name: .popStack, userInfo: [stackKeyNotification: stack])
	}
}
