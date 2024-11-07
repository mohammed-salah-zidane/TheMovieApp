//
//  MovieRepository.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine
import Domain

/// Repository responsible for fetching movies.
public class MovieRepository: MovieRepositoryProtocol {
    private let remoteDataSource: RemoteDataSourceProtocol

    /// Initializes the repository with a remote data source.
    public init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    // Updated to include optional genreId parameter
    public func fetchTrendingMovies(page: Int, genreId: Int?) -> AnyPublisher<[Movie], Error> {
        remoteDataSource.fetchTrendingMovies(page: page, genreId: genreId)
    }

    // Added search function
    public func searchMovies(query: String, page: Int) -> AnyPublisher<[Movie], Error> {
        remoteDataSource.searchMovies(query: query, page: page)
    }
}
