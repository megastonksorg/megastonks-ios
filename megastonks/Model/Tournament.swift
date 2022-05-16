//
//  Tournament.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-05-15.
//

import Foundation
import UIKit

struct Tournament : Codable {
	var name: String
	var detail: String
	var image: URL
	var reward: Double
	var isActive: Bool
}
