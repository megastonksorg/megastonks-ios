//
//  TournamentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

struct TournamentView: View {
	let innerPadding: CGFloat = 2
    var body: some View {
		
		RoundedRectangle(cornerRadius: SizeConstants.cornerRadius)
			.fill(LinearGradient.megaStonksGreen)
			.frame(height: SizeConstants.tournamentCardHeight)
			.overlay {
				AsyncImage(url: URL(string: "https://images.pexels.com/photos/10458845/pexels-photo-10458845.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")!)
					.frame(height: SizeConstants.tournamentCardHeight - 4)
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
									VStack {
										Text("League of Legends North America Sponsors")
											.font(.system(size: 16, weight: .semibold, design: .rounded))
											.foregroundColor(.white)
											.lineLimit(1)
											.padding(.top, 6)
											.padding(.horizontal, 10)
										Spacer()
									}
								}
						}
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
