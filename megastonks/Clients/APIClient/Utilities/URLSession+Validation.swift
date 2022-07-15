//
//  URLSession+Validation.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-05.
//

import Foundation
import Combine

extension URLSession.DataTaskPublisher {
	func validateStatusCode() -> AnyPublisher<Output, Error> {
		return tryMap { data, response in
			if let response = response as? HTTPURLResponse, (400..<600).contains(response.statusCode) {
				throw AppError.apiClientError(.httpError(response: response, data: data))
				
			} else {
				return (data, response)
			}
		}
		.eraseToAnyPublisher()
	}
}
