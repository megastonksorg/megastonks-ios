//
//  User.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-30.
//

import Foundation

struct User: Encodable {
	let walletAddress: String
	let fullName: String
	let userName: String
	let profilePhoto: URL
	let currency: String
	let acceptTerms: Bool
	let isOnboarded: Bool
}
