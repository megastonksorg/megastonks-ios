//
//  AuthenticateView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-30.
//

import SwiftUI

struct AuthenticateView: View {
	
	@StateObject var viewModel: ViewModel = ViewModel()
	
	var body: some View {
		Text("Click to Signin")
	}
}

struct AuthenticateView_Previews: PreviewProvider {
	static var previews: some View {
		AuthenticateView()
	}
}
