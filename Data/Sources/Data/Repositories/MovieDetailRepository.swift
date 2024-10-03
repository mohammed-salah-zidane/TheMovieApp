//
//  MovieDetailRepository.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine
import Domain

/// Repository responsible for fetching movie details.
public class MovieDetailRepository: MovieDetailRepositoryProtocol {
    private let remoteDataSource: RemoteDataSourceProtocol

    /// Initializes the repository with a remote data source.
    public init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    public func fetchMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        remoteDataSource.fetchMovieDetail(id: id)
    }
}
