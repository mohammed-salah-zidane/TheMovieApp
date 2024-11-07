//
//  NetworkClient.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//
import Combine
import Foundation

/// Protocol defining the network client's capabilities.
public protocol NetworkClientProtocol {
    /// Fetches data from a URL and decodes it into the specified type.
    func fetch<T: Decodable>(url: String) -> AnyPublisher<T, Error>
}

/// Network client responsible for making API calls.
public class NetworkClient: NetworkClientProtocol {
    private let session: URLSession

    /// Initializes the network client with a URLSession.
    public init(session: URLSession = .shared) {
        self.session = session
    }

    /// Fetches data from the given URL and decodes it into the specified type.
    public func fetch<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        print("➡️ Requesting URL: \(url.absoluteString)")

        return session.dataTaskPublisher(for: url)
            .handleEvents(
                receiveSubscription: { _ in
                    print("📡 Starting network request...")
                },
                receiveOutput: { data, response in
                    if let httpResponse = response as? HTTPURLResponse {
                        print("✅ Received response: \(httpResponse.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
                    }
                    print("📦 Data size: \(data.count) bytes")

                    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                       let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("📝 JSON Response:\n\(jsonString)")
                    } else if let stringData = String(data: data, encoding: .utf8) {
                        print("📝 Response (String):\n\(stringData)")
                    } else {
                        print("⚠️ Unable to parse response data.")
                    }
                },
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("🛑 Request completed successfully.")
                    case .failure(let error):
                        print("❌ Request failed with error: \(error.localizedDescription)")
                    }
                }
            )
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .handleEvents(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("🎉 Decoding completed successfully.")
                    case .failure(let error):
                        print("⚠️ Decoding failed with error: \(error.localizedDescription)")
                    }
                }
            )
            .eraseToAnyPublisher()
    }
}
