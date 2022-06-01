//
//  WelcomePageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-31.
//

import SwiftUI

struct WelcomePageView: View {
	var body: some View {
		VStack {
			Spacer()
			Button(action: {}) {
				Text("Create a new Wallet")
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
