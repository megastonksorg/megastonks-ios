//
//  ImagePlaceHolderView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-31.
//

import SwiftUI

struct ImagePlaceHolderView: View {
	var body: some View {
		Color.black.opacity(0.8)
			.background(.ultraThinMaterial)
			.overlay(
				ProgressView().frame(width: .infinity, height: .infinity)
					.tint(.white)
			)
	}
}

struct ImagePlaceHolderView_Previews: PreviewProvider {
	static var previews: some View {
		ImagePlaceHolderView()
	}
}
