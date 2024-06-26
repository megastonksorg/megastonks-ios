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
		case couldNotImportWalletForSigning
		case couldNotVerifyMnemonic
		case errorSigningMessage
		case errorRetrievingMnemonic
		
		var title: String { "Wallet Error" }
	}
	
	enum APIClientError: Error {
		case invalidURL
		case httpError(statusCode: Int, data: Data)
		case decodingError
		case rawError(String)
		var title: String { "API Error" }
	}
	
	case walletError(WalletError)
	case apiClientError(APIClientError)
}

extension AppError.WalletError: LocalizedError {
	var errorDescription: String? {
		switch self {
			case .couldNotGenerateWallet:
				return NSLocalizedString(
					"Could not generate a new wallet",
					comment: "Unable to Generate New Wallet"
				)
			case .couldNotImportWallet:
				return NSLocalizedString(
					"Could not import a valid wallet for the mnemonic",
					comment: "Invalid Mnemonic"
				)
			case .couldNotImportWalletForSigning:
				return NSLocalizedString(
					"Could not import a valid wallet for your existing mnemonic",
					comment: "Invalid Mnemonic"
				)
			case .couldNotVerifyMnemonic:
				return NSLocalizedString(
					"Could not verify the secret phrase you entered. Please try again and remember the order of the words is important",
					comment: "Invalid Mnemonic"
				)
			case .errorSigningMessage:
				return NSLocalizedString(
					"Error encountered while signing message with wallet",
					comment: "Error Signing Message"
				)
			case .errorRetrievingMnemonic:
				return NSLocalizedString(
					"Error encountered while retrieving mnemonic",
					comment: "Error Retrieving Mnemonic"
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
			case let .httpError(statusCode: statusCode, data: data):
				return NSLocalizedString(
					"Error \(statusCode) Processing Request: \(String(decoding: data, as: UTF8.self))",
					comment: "HTTP Error"
				)
			case .decodingError:
				return NSLocalizedString(
					"Error Decoding Object: Please try that again",
					comment: "Decoder Error"
				)
			case .rawError(let error):
				return NSLocalizedString(
					"\(error)",
					comment: "Raw Error"
				)
		}
	}
}
