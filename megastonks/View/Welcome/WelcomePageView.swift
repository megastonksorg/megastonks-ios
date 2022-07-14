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
	
	init() {
		UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.megaStonksGreen)
		UIPageControl.appearance().pageIndicatorTintColor = UIColor(.megaStonksGreen).withAlphaComponent(0.2)
	}
	
	var body: some View {
		VStack(spacing: 0) {
			TabView {
				ForEach(0..<6, id: \.self) { num in
					Text("Onboarding Page \(num)")
						.font(.title3)
						.foregroundColor(.white)
				}
			}
			.tint(.megaStonksGreen)
			.tabViewStyle(.page(indexDisplayMode: .always))
			
			Group {
				Button(action: {
					let wallet = WalletClient.shared.generateNewWallet()!
					self.wallet = wallet
					print("Wallet: \(wallet.getAddressForCoin(coin: .ethereum))")
				}) {
					Text("Create a new Wallet")
				}
				.buttonStyle(ExpandedButtonStyle())
				
				Button(action: {
					let signature = WalletClient.shared.signMessage(wallet: wallet!)
					print("Signature: \(signature)")
				}) {
					Text("Import an existing  wallet")
				}
				.buttonStyle(ExpandedButtonStyle(invertedStyle: true))
			}
			.textCase(.uppercase)
			.padding(10)
			.padding(.horizontal, 4)
		}
		.background(AppBackgroundView())
	}
}

struct WelcomePageView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomePageView()
	}
}
