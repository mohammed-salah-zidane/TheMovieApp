//
//  GenreRepository.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//
// Domain/Sources/Repositories/GenreRepositoryProtocol.swift

import Combine
import Domain

/// Repository responsible for fetching genres.
public class GenreRepository: GenreRepositoryProtocol {
    private let remoteDataSource: RemoteDataSourceProtocol

    /// Initializes the repository with a remote data source.
    public init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    public func fetchGenres() -> AnyPublisher<[Genre], Error> {
        remoteDataSource.fetchGenres()
    }
}

