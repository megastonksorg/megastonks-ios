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
    }
}

struct TournamentView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentView()
    }
}
