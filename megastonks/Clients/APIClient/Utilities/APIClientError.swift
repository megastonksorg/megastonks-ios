//
//  APIClientError.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-05.
//

import Foundation

enum APIClientError: Error {
    case invalidURL
    case httpError(response: URLResponse, data: Data)
}

extension APIClientError: LocalizedError {
    public var errorDescription: String? {
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
