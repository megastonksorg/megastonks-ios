//
//  APIClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-27.
//

import Combine
import Foundation

struct WeatherForecastElement: Codable {
	let date: String?
	let temperatureC, temperatureF: Int?
	let summary: String?
}

typealias WeatherForecast = [WeatherForecastElement]

typealias APIClientError = AppError.APIClientError

protocol APIRequests {
	func testAPI() -> AnyPublisher<WeatherForecast, APIClientError>
	func uploadImage(imageData: Data) -> AnyPublisher<URL, APIClientError>
}

final class APIClient: APIRequests {
	
	static let shared: APIClient = APIClient()

	let decoder: JSONDecoder = JSONDecoder()
	
	func testAPI() -> AnyPublisher<WeatherForecast, APIClientError> {
		let appRequest = APPUrlRequest(
			token: nil,
			httpMethod: .get,
			pathComponents: ["weatherforecast"]
		)
		
		return apiRequest(appRequest: appRequest, output: WeatherForecast.self)
	}
	
	func uploadImage(imageData: Data) -> AnyPublisher<URL, APIClientError> {
		let appRequest = APPUrlRequest(
			token: nil,
			httpMethod: .put,
			pathComponents: ["fileUpload", "image"],
			body: imageData
		)
		return apiRequest(appRequest: appRequest, output: URL.self)
	}
	
	private func apiRequest<Output: Codable>(appRequest: APPUrlRequest, output: Output.Type) -> AnyPublisher<Output, APIClientError> {
		do {
			return try urlRequest(urlRequest: appRequest.urlRequest)
				.decode(type: Output.self, decoder: self.decoder)
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
