//
//  RegisterRequest.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-30.
//

import Foundation

struct RegisterRequest: Encodable {
	let walletAddress: String
	let profilePhoto: URL
	let fullName: String
	let userName: String
	let acceptTerms: Bool
}

struct RegisterResponse: Decodable {
	let walletAddress: String
	let fullName: String
	let userName: String
	let profilePhoto: URL
	let currency: String
	let acceptTerms: Bool
	let isOnboarded: Bool
	let role: String
	let verified: Date?
}
