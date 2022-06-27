//
//  WelcomePageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-31.
//

import SwiftUI
import WalletCore

struct WelcomePageView: View {
    @State var wallet: HDWallet?
    
	var body: some View {
		VStack {
			Spacer()
            
            Group {
                Button(action: {
                   let wallet = WalletClient.shared.generateNewWallet()!
                    self.wallet = wallet
                    print("Wallet: \(wallet.getAddressForCoin(coin: .ethereum))")
                }) {
                    Text("Create a new Wallet")
                }
                
                Button(action: {
                    let signature = WalletClient.shared.signMessage(wallet: wallet!)
                    print("Signature: \(signature)")
                }) {
                    Text("Sign Message")
                }
            }
			.buttonStyle(ExpandedButtonStyle())
			.padding()
			.padding(.horizontal)
		}
		.background(Color.app.background)
	}
}

struct WelcomePageView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomePageView()
	}
}
