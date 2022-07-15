//
//  WalletClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-01.
//

import WalletCore
import SwiftUI

class WalletClient {
	private let passPhrase: String = ""
	static let shared = WalletClient()
	
	init() {}
	
	func generateNewWallet() -> HDWallet? {
		return HDWallet(strength: 128, passphrase: passPhrase)
	}
	
	func importWallet(mnemonic: String) -> HDWallet? {
		return HDWallet(mnemonic: mnemonic, passphrase: passPhrase, check: true)
	}
	
	func signMessage(wallet: HDWallet) -> String {
		let privateKey = wallet.getKeyForCoin(coin: .ethereum)
		let publicKey = privateKey.getPublicKeySecp256k1(compressed: false)
		print("Public Key: \(publicKey.description)")
		let message = "Today I heard something new and unmemorable."
		
		let hash = WalletCore.Hash.keccak256(data: message.data(using: .utf8)!)
		let signature = privateKey.sign(digest: hash, curve: .secp256k1)!
		return signature.hexString
	}
}
