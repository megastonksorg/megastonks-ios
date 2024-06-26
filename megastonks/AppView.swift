//
//  ContentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

struct AppView: View {
	
	@StateObject var appRouter = AppRouter()
	@StateObject var appState = AppState()
	
	init() { NavBarTheme.setup() }
	
	var body: some View {
		switch appState.appMode {
			case .welcome(let welcomePageViewModel):
				WelcomePageView(viewModel: welcomePageViewModel)
					.environmentObject(appRouter)
			case .authentication(let authenticationViewModel):
				AuthenticateView(viewModel: authenticationViewModel)
			case .loggedIn:
				EmptyView()
		}
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
