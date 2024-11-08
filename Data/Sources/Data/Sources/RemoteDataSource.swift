//
//  RemoteDataSource.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//
//

import Combine
import Foundation
import Domain

/// Remote data source for fetching data from APIs.
public class RemoteDataSource: RemoteDataSourceProtocol {
    private let networkClient: NetworkClientProtocol

    /// Initializes the remote data source with a network client.
    public init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    public func fetchGenres() -> AnyPublisher<[Genre], Error> {
        networkClient.fetch(url: Endpoints.genres.url)
            .map { (response: GenreResponse) in response.genres }
            .eraseToAnyPublisher()
    }

    public func fetchTrendingMovies(page: Int, genreIds: [Int]? = nil) -> AnyPublisher<[Movie], Error> {
        networkClient.fetch(url: Endpoints.trendingMovies(page: page, genreIds: genreIds).url)
            .map { (response: MovieResponse) in response.results }
            .eraseToAnyPublisher()
    }

    public func fetchMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        networkClient.fetch(url: Endpoints.movieDetail(id: id).url)
    }

    public func searchMovies(query: String, page: Int) -> AnyPublisher<[Movie], Error> {
        networkClient.fetch(url: Endpoints.search(query: query, page: page).url)
            .map { (response: MovieResponse) in response.results }
            .eraseToAnyPublisher()
    }
}

// Helper structs for decoding API responses
private struct GenreResponse: Decodable {
    let genres: [Genre]
}

private struct MovieResponse: Decodable {
    let results: [Movie]
}
