//
//  TournamentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

struct TournamentView: View {
    var body: some View {
		
		RoundedRectangle(cornerRadius: SizeConstants.cornerRadius)
			.fill(LinearGradient.megaStonksGreen)
			.frame(height: SizeConstants.tournamentCardHeight)
			.overlay {
				AsyncImage(url: URL(string: "https://images.pexels.com/photos/10458845/pexels-photo-10458845.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")!)
					.frame(height: SizeConstants.tournamentCardHeight - 4)
					.clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
					.padding(2)
			}
			.padding(.horizontal)
		
    }
}

struct TournamentView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentView()
    }
}
