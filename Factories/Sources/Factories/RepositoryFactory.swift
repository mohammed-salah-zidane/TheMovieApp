//
//  RepositoryFactory.swift
//  Factories
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Domain
import Data

/// Factory responsible for creating repository instances.
public class RepositoryFactory {
    private let remoteDataSource: RemoteDataSourceProtocol

    /// Initializes the factory with a remote data source.
    public init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    /// Creates an instance of GenreRepositoryProtocol.
    public func createGenreRepository() -> GenreRepositoryProtocol {
        return GenreRepository(remoteDataSource: remoteDataSource)
    }

    /// Creates an instance of MovieRepositoryProtocol.
    public func createMovieRepository() -> MovieRepositoryProtocol {
        return MovieRepository(remoteDataSource: remoteDataSource)
    }

    /// Creates an instance of MovieDetailRepositoryProtocol.
    public func createMovieDetailRepository() -> MovieDetailRepositoryProtocol {
        return MovieDetailRepository(remoteDataSource: remoteDataSource)
    }
}

