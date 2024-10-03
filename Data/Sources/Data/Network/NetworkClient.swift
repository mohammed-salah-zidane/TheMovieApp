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

        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


