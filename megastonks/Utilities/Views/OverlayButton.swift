//
//  OverlayButton.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-16.
//

import SwiftUI

struct OverlayButton: View {
	
	let title: String
	let buttonSize: CGSize = SizeConstants.overlayButtonSize
	
    var body: some View {
		Rectangle()
			.fill(LinearGradient.megaStonksGreen)
			.frame(width: buttonSize.width, height: buttonSize.height)
			.cornerRadius(SizeConstants.cornerRadius - 8, corners: [.topLeft, .bottomRight])
			.overlay{
				Text(title)
					.textCase(.uppercase)
					.foregroundColor(.white)
					.font(.system(size: 18, weight: .bold, design: .rounded))
			}
    }
}

struct OverlayButton_Previews: PreviewProvider {
    static var previews: some View {
        OverlayButton(title: "Live")
    }
}
