//
//  AppError.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-15.
//

import Foundation

enum AppError: Error {
	
	enum WalletError: Error {
		case couldNotGenerateWallet
		case couldNotImportWallet
		case errorSigningMessage
	}
	
	enum APIClientError: Error {
		case invalidURL
		case httpError(response: URLResponse, data: Data)
	}
	
	case walletError(WalletError)
	case apiClientError(APIClientError)
}

extension AppError.WalletError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .couldNotGenerateWallet:
			return NSLocalizedString(
				"Could not generate a new Wallet",
				comment: "Unable to Generate new Wallet"
			)
		case .couldNotImportWallet:
			return NSLocalizedString(
				"Could not import a valid wallet for the mnemonic",
				comment: "Invalid Mnemonic"
			)
		case .errorSigningMessage:
			return NSLocalizedString(
				"Error encountered while signing message with wallet",
				comment: "Error Signing Message"
			)
		}
	}
}

extension AppError.APIClientError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return NSLocalizedString(
				"Request URL could not be formed or is Invalid",
				comment: "Invalid Url"
			)
		case let .httpError(response: _, data: data):
			return NSLocalizedString(
				"Error Processing Request: \(String(decoding: data, as: UTF8.self))",
				comment: "HTTP Error"
			)
		}
	}
}
