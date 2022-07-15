//
//  ContentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

struct AppView: View {
	
	init() { NavBarTheme.setup() }
	
	var body: some View {
		WelcomePageView()
	}
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
		AppView()
	}
}
