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
		VStack {
			AsyncImage(url: user.profilePhoto) { image in
				image
					.resizable()
					.clipShape(Circle())
			}
			placeholder:  {
				ImagePlaceholderView()
			}
			.frame(dimension: SizeConstants.profileImageFrame)
			.padding(.top, 40)
			
			Text(viewModel.user.fullName)
				.font(.title3)
				.fontWeight(.semibold)
				.foregroundColor(.white)
				.padding(.top)
			
			Text(viewModel.user.userName)
				.font(.app.subTitle)
				.foregroundColor(.gray)
			
			VStack(spacing: 4) {
				ExpandedHStack {
					Text("ETHEREUM")
						.font(.app.footer)
						.foregroundColor(.gray)
				}

				ExpandedHStack {
					Text(String(stringLiteral: "$_,_ _ _._ _ USD"))
						.font(.title3)
						.fontWeight(.semibold)
						.foregroundColor(.white)
						.overlay {
							Text(String(stringLiteral: "* * * * * * *"))
								.offset(x: -18)
						}
				}
				
				ExpandedHStack {
					Text("WALLET ADDRESS")
						.font(.app.footer)
						.foregroundColor(.gray)
				}
				.padding(.top, 30)
				
				HStack {
					Text(viewModel.user.walletAddress.uppercased())
						.font(.title3)
						.fontWeight(.semibold)
						.foregroundColor(.white)
					
					Spacer()
					
					Button(action: { self.viewModel.copyAddress() }) {
						Image(systemName: "doc.on.doc.fill")
					}
				}
			}
			.foregroundColor(.white)
			.multilineTextAlignment(.leading)
			.lineLimit(1)
			.padding()
			.background(TextFieldBackgroundView())
			.padding(.top, 60)
			
			Spacer()
			
			Text("By clicking authenticate, you will sign a message with your wallet for verification")
				.font(.caption)
				.foregroundColor(.gray)
				.multilineTextAlignment(.center)
			
			Button(action: {}) {
				Text("Authenticate")
			}
			.buttonStyle(ExpandedButtonStyle())
		}
		.padding(.horizontal)
		.banner(data: self.$viewModel.banner)
		.toolbar {
			ToolbarItem(placement: .principal) {
				AppToolBar(.principal, principalTitle: "Authentication")
			}
			ToolbarItem(placement: .navigationBarTrailing) {
				AppToolBar(
					.trailing,
					trailingTitle: "Cancel",
					trailingClosure: { self.viewModel.cancel() }
				)
			}
		}
		.background(Color.app.background)
	}
}

fileprivate struct ExpandedHStack<Content: View>: View {
	@ViewBuilder var content: Content
	
	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content()
	}
	
	var body: some View {
		HStack {
			content
			Spacer()
		}
	}
}

struct AuthenticateView_Previews: PreviewProvider {
	static var previews: some View {
		AuthenticateView(viewModel: .init(user: User.noop))
	}
}
