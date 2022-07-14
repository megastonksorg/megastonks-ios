//
//  Gradients.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import SwiftUI

public extension LinearGradient {
	static let background = LinearGradient(colors: [.megaStonksGreen, .megaStonksGreen, .black, .black], startPoint: .top, endPoint: .bottom)
	
	static let dropShadow = LinearGradient(colors: [.clear, .black.opacity(0.2), .black.opacity(0.2), .black.opacity(0.2)], startPoint: .top, endPoint: .bottom)
	
	static let black = LinearGradient(colors: [.black, .black.opacity(0.2), .black.opacity(0.2), .black.opacity(0.2)], startPoint: .top, endPoint: .bottom)
	
	static let megaStonksGreen = LinearGradient(colors: [.megaStonksGreenDark, .megaStonksGreen], startPoint: .leading, endPoint: .trailing)
	
	static let white = LinearGradient(colors: [.white], startPoint: .leading, endPoint: .trailing)
	
	static let clear = LinearGradient(colors: [], startPoint: .center, endPoint: .center)
}
