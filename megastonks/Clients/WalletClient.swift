//
//  WalletClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-01.
//

import WalletCore
import SwiftUI

class WalletClient {
	
	struct SignedMessage {
		let signature: String
		let address: String
	}
	
	private let passPhrase: String = ""
	private let coinType: WalletCore.CoinType = .ethereum
	
	static let shared = WalletClient()
	
	init() {}
	
	func generateNewWallet() -> HDWallet? {
		return HDWallet(strength: 128, passphrase: passPhrase)
	}
	
	func importWallet(mnemonic: String) -> HDWallet? {
		return HDWallet(mnemonic: mnemonic, passphrase: passPhrase, check: true)
	}
	
	func signMessage(wallet: HDWallet, message: String) -> Result<SignedMessage, AppError.WalletError> {
		let privateKey = wallet.getKeyForCoin(coin: coinType)

		guard let messageData = message.data(using: .utf8)
		else { return .failure(.errorSigningMessage) }
		
		let hash: Data = WalletCore.Hash.keccak256(data: messageData)
		
		guard let signature = privateKey.sign(digest: hash, curve: .secp256k1)
		else { return .failure(.errorSigningMessage) }
		
		let address = privateKey.getPublicKeySecp256k1(compressed: false).description
		
		return .success(SignedMessage(signature: signature.hexString, address: address))
	}
}
