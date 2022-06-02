//
//  WalletClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-01.
//

import WalletCore

class WalletClient {
	let shared = WalletClient()
	
	init() {}
	
	func generateNewWallet() -> HDWallet? {
		return HDWallet(strength: 128, passphrase: "")
	}
}
