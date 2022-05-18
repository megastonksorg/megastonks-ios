//
//  GameCardView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-17.
//

import SwiftUI

struct GameCardView: View {
	let size: CGSize = SizeConstants.gameCardSize
	let innerPadding: CGFloat = SizeConstants.cardInnerPadding
	var body: some View {
		RoundedRectangle(cornerRadius: SizeConstants.cornerRadius)
			.fill(LinearGradient.megaStonksGreen)
			.frame(width: size.width, height: size.height)
			.overlay(
				AsyncImage(url: URL(string: "https://images.pexels.com/photos/10458845/pexels-photo-10458845.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")!)
					.frame(width: size.width - innerPadding, height: size.height - innerPadding)
					.clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
					.overlay(alignment: .bottomTrailing) {
						OverlayButton(title: "Play")
					}
			)
	}
}

struct GameCardView_Previews: PreviewProvider {
	static var previews: some View {
		GameCardView()
	}
}
