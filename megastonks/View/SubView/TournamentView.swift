//
//  TournamentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

struct TournamentView: View {
	let innerPadding: CGFloat = SizeConstants.cardInnerPadding
	
	var body: some View {
		
		RoundedRectangle(cornerRadius: SizeConstants.cornerRadius)
			.fill(LinearGradient.megaStonksGreen)
			.frame(height: SizeConstants.tournamentCardHeight)
			.overlay {
				AsyncImage(url: URL(string: "https://images.pexels.com/photos/10458845/pexels-photo-10458845.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")!)
					.frame(height: SizeConstants.tournamentCardHeight - innerPadding)
					.clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
					.padding(innerPadding)
					.overlay{
						VStack {
							Spacer()
							Rectangle()
								.frame(height: SizeConstants.tournamentCardHeight * 0.44)
								.background(Color.black.opacity(0.2))
								.background(.ultraThinMaterial)
								.cornerRadius(SizeConstants.cornerRadius, corners: [.bottomLeft, .bottomRight])
								.padding(innerPadding)
								.overlay {
									VStack(alignment: .leading) {
										Text("League of Legends North America Sponsors")
											.font(.system(size: 16, weight: .semibold, design: .rounded))
											.foregroundColor(.white)
											.lineLimit(1)
											.padding(.vertical, 2)
										HStack {
											Text("KIA will continue to sponsor the 'Player of the Game' broadcast segment alongside joining")
												.font(.system(size: 14, weight: .regular, design: .rounded))
												.foregroundColor(.white)
												.lineLimit(2)
											Spacer()
												.frame(width: SizeConstants.overlayButtonSize.width)
										}
									}
									.padding(.horizontal, 10)
								}
						}
					}
					.overlay(alignment: .bottomTrailing) {
						OverlayButton(title: "Live")
					}
			}
			.padding(.horizontal)
		
	}
}

struct TournamentView_Previews: PreviewProvider {
	static var previews: some View {
		TournamentView()
	}
}
