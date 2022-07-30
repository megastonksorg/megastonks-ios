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
	func requestAuthentication() -> AnyPublisher<String, APIClientError>
	func authenticateUser(model: AuthenticateRequest) -> AnyPublisher<AuthenticateResponse, APIClientError>
	func registerUser(model: RegisterRequest) -> AnyPublisher<RegisterResponse, APIClientError>
	func uploadImage(imageData: Data) -> AnyPublisher<URL, APIClientError>
}

final class APIClient: APIRequests {
	
	static let shared: APIClient = APIClient()

	let decoder: JSONDecoder = JSONDecoder()
	
	func requestAuthentication() -> AnyPublisher<String, APIClientError> {
		let authenticationRequest = APPUrlRequest(
			token: nil,
			httpMethod: .get,
			pathComponents: ["requestAuthentication"],
			body: nil
		)
		return apiRequest(appRequest: authenticationRequest, output: String.self)
	}
	
	func authenticateUser(model: AuthenticateRequest) -> AnyPublisher<AuthenticateResponse, APIClientError> {
		let authenticateRequest = APPUrlRequest(
			token: nil,
			httpMethod: .post,
			pathComponents: ["authenticate"],
			body: model
		)
		return apiRequest(appRequest: authenticateRequest, output: AuthenticateResponse.self)
	}
	
	func registerUser(model: RegisterRequest) -> AnyPublisher<RegisterResponse, APIClientError> {
		let registerRequest = APPUrlRequest(
			token: nil,
			httpMethod: .post,
			pathComponents: ["register"],
			body: model
		)
		return apiRequest(appRequest: registerRequest, output: RegisterResponse.self)
	}
	
	func uploadImage(imageData: Data) -> AnyPublisher<URL, APIClientError> {
		let imageUploadRequest = APPUrlRequest(
			token: nil,
			httpMethod: .put,
			pathComponents: ["mediaUpload", "image"],
			body: imageData
		)
		return apiRequest(appRequest: imageUploadRequest, output: URL.self)
	}
	
	private func apiRequest<Output: Decodable>(appRequest: APPUrlRequest, output: Output.Type) -> AnyPublisher<Output, APIClientError> {
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
