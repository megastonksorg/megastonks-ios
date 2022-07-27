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

protocol APIRequests {
	func testAPI() -> AnyPublisher<WeatherForecast, AppError.APIClientError>
	func uploadImage(imageData: Data) -> AnyPublisher<URL, AppError.APIClientError>
}

final class APIClient: APIRequests {
	let shared: APIClient = APIClient()

	let decoder: JSONDecoder = JSONDecoder()
	
	func testAPI() -> AnyPublisher<WeatherForecast, AppError.APIClientError> {
		let appRequest = APPUrlRequest(
			token: nil,
			httpMethod: .put,
			pathComponents: ["weatherforecast"]
		)
		
		return apiRequest(appRequest: appRequest)
	}
	
	func uploadImage(imageData: Data) -> AnyPublisher<URL, AppError.APIClientError> {
		let appRequest = APPUrlRequest(
			token: nil,
			httpMethod: .put,
			pathComponents: ["fileUpload", "image"],
			body: imageData
		)
		return apiRequest(appRequest: appRequest)
	}
	
	private func apiRequest<Output: Codable>(appRequest: APPUrlRequest) -> AnyPublisher<Output, AppError.APIClientError> {
		do {
			return try urlRequest(urlRequest: appRequest.urlRequest)
				.decode(type: Output.self, decoder: self.decoder)
				.mapError { _ in AppError.APIClientError.decodingError }
				.eraseToAnyPublisher()
		}
		catch let error {
			return Fail(error: AppError.APIClientError.rawError(error.localizedDescription))
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
