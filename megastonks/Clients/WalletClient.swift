//
//  WalletClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-06-01.
//

import WalletCore
import SwiftUI

class WalletClient {
	static let shared = WalletClient()
	
	init() {}
	
	func generateNewWallet() -> HDWallet? {
		return HDWallet(strength: 128, passphrase: "")
	}
    
    func signMessage(wallet: HDWallet) -> String {
        let privateKey = wallet.getKeyForCoin(coin: .ethereum)
        let publicKey = privateKey.getPublicKeySecp256k1(compressed: false)
        print("Public Key: \(publicKey.description)")
        let message = "Today I heard something new and unmemorable."
        
        let hash = WalletCore.Hash.keccak256(data: message.data(using: .utf8)!)
        print("HASH: \(String(describing: hash))")
//        let hashedMessage = Data(hexString: "5f16f4c7f149ac4f9510d9cf8cf384038ad348b3bcdc01915f95de12df9d1b02")
        let signature = privateKey.sign(digest: hash, curve: .secp256k1)!
        return signature.hexString
    }
}

extension Data {
    public var hexString: String {
        return map({ String(format: "%02x", $0) }).joined()
    }
    
    init?(hexString: String) {
      let len = hexString.count / 2
      var data = Data(capacity: len)
      var i = hexString.startIndex
      for _ in 0..<len {
        let j = hexString.index(i, offsetBy: 2)
        let bytes = hexString[i..<j]
        if var num = UInt8(bytes, radix: 16) {
          data.append(&num, count: 1)
        } else {
          return nil
        }
        i = j
      }
      self = data
    }
}
