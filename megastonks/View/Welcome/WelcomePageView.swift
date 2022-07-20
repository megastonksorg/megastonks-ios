//
//  WelcomePageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-31.
//

import SwiftUI

struct WelcomePageView: View {
	@StateObject var viewModel: ViewModel = ViewModel()
	
	@EnvironmentObject var appRouter: AppRouter
	
	init() {
		UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.megaStonksGreen)
		UIPageControl.appearance().pageIndicatorTintColor = UIColor(.megaStonksGreen).withAlphaComponent(0.2)
	}
	
	var body: some View {
		NavigationStack(path: $appRouter.stack1) {
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
					Button(action: { viewModel.generateNewWallet() }) {
						Text("Create a new Wallet")
					}
					.buttonStyle(ExpandedButtonStyle())
					
					Button(action: { viewModel.importWallet() }) {
						Text("Import an existing  wallet")
					}
					.buttonStyle(ExpandedButtonStyle(invertedStyle: true))
				}
				.textCase(.uppercase)
				.padding(10)
				.padding(.horizontal, 4)
			}
			.background(AppBackgroundView())
			.overlay(isShown: viewModel.isLoading) {
				AppProgressView()
			}
			.banner(data: $viewModel.banner)
			.navigationTitle("")
			.navigationDestination(for: AppRouter.Route.Stack1.self) { route in
				Group {
					switch route {
					case .createWallet:
						NewSecretPhraseView()
								.environmentObject(appRouter)
					case .importWallet:
						ImportSecretPhraseView()
								.environmentObject(appRouter)
					case .createProfile:
						ProfileEditingView()
								.environmentObject(appRouter)
					}
				}
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle("")
			}
		}
	}
}

struct WelcomePageView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomePageView()
	}
}
