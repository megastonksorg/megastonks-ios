//
//  APIClientHelpers.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-05.
//

import Foundation
import Combine

enum APIClientError: Error {
    case httpError(response: URLResponse, data: Data)
}

extension APIClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .httpError(response: _, data: data):
            return NSLocalizedString(
                "Error Processing Request: \(String(decoding: data, as: UTF8.self))",
                comment: "HTTP Error"
            )
        }
    }
}

extension URLSession.DataTaskPublisher {
    func validateStatusCode() -> AnyPublisher<Output, Error> {
        return tryMap { data, response in
            if let response = response as? HTTPURLResponse, (400..<600).contains(response.statusCode) {
                throw APIClientError.httpError(response: response, data: data)
                
            } else {
                return (data, response)
            }
        }
        .eraseToAnyPublisher()
    }
}
