//
//  AuthenticateView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-30.
//

import SwiftUI

struct AuthenticateView: View {
	
	@StateObject var viewModel: ViewModel
	
	init(viewModel: ViewModel) {
		self._viewModel = StateObject(wrappedValue: viewModel)
	}
	
	var body: some View {
		let user = viewModel.user
		VStack(spacing: 20) {
			AsyncImage(url: user.profilePhoto) { image in
				image
					.resizable()
					.clipShape(Circle())
			}
			placeholder:  {
				ImagePlaceholderView()
			}
			.frame(dimension: SizeConstants.profileImageFrame)
			
			Group {
				Text("Welcome ")
					.foregroundColor(.gray)
				+
				Text(user.fullName)
					.font(.title3)
				Text("@\(user.userName)")
				Text("\(user.currency)")
				Text("Wallet \(user.walletAddress)")
			}
			.font(.body)
			.foregroundColor(.white)
			
			Spacer()
			Button(action: {}) {
				Text("Click to Sign in")
			}
			.buttonStyle(ExpandedButtonStyle())
			.padding(.horizontal)
		}
		.background(Color.app.background)
	}
}

struct AuthenticateView_Previews: PreviewProvider {
	static var previews: some View {
		AuthenticateView(viewModel: .init(user: User.noop))
	}
}
