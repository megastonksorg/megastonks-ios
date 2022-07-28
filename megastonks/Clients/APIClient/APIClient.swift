//
//  APIClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-27.
//

import Combine
import Foundation

typealias APIClientError = AppError.APIClientError

protocol APIRequests {
	func uploadImage(imageData: Data) -> AnyPublisher<URL, APIClientError>
}

final class APIClient: APIRequests {
	
	static let shared: APIClient = APIClient()

	let decoder: JSONDecoder = JSONDecoder()
	
	func uploadImage(imageData: Data) -> AnyPublisher<URL, APIClientError> {
		let appRequest = APPUrlRequest(
			token: nil,
			httpMethod: .put,
			pathComponents: ["mediaUpload", "image"],
			body: imageData
		)
		return apiRequest(appRequest: appRequest, output: URL.self)
	}
	
	private func apiRequest<Output: Codable>(appRequest: APPUrlRequest, output: Output.Type) -> AnyPublisher<Output, APIClientError> {
		do {
			return try urlRequest(urlRequest: appRequest.urlRequest)
				.decode(type: output, decoder: self.decoder)
				.mapError{ error in
					if let error = error as? AppError.APIClientError {
						return error
					}
					else {
						return AppError.APIClientError.rawError(error.localizedDescription)
					}
				}
				.eraseToAnyPublisher()
		}
		catch let error {
			return Fail(error: AppError.APIClientError.rawError(String(describing: error)))
					.eraseToAnyPublisher()
		}
	}
	
	private func urlRequest(urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
		return URLSession.shared.dataTaskPublisher(for: urlRequest)
			.validateStatusCode()
			.map(\.data)
			.eraseToAnyPublisher()
	}
}
