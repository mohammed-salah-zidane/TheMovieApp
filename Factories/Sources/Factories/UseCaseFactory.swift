//
//  UseCaseFactory.swift
//  Factories
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Domain

/// Factory responsible for creating use case instances.
public class UseCaseFactory {
    private let repositoryFactory: RepositoryFactory

    /// Initializes the factory with a repository factory.
    public init(repositoryFactory: RepositoryFactory) {
        self.repositoryFactory = repositoryFactory
    }

    /// Creates an instance of GetGenresUseCaseProtocol.
    public func createGetGenresUseCase() -> GetGenresUseCaseProtocol {
        let repository = repositoryFactory.createGenreRepository()
        return GetGenresUseCase(repository: repository)
    }

    /// Creates an instance of GetTrendingMoviesUseCaseProtocol.
    public func createGetTrendingMoviesUseCase() -> GetTrendingMoviesUseCaseProtocol {
        let repository = repositoryFactory.createMovieRepository()
        return GetTrendingMoviesUseCase(repository: repository)
    }

    /// Creates an instance of GetMovieDetailUseCaseProtocol.
    public func createGetMovieDetailUseCase() -> GetMovieDetailUseCaseProtocol {
        let repository = repositoryFactory.createMovieDetailRepository()
        return GetMovieDetailUseCase(repository: repository)
    }
}

