//
//  GetTrendingMoviesUseCase.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Implementation of GetTrendingMoviesUseCaseProtocol.
public class GetTrendingMoviesUseCase: GetTrendingMoviesUseCaseProtocol {
    private let repository: MovieRepositoryProtocol

    /// Initializes the use case with a movie repository.
    public init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    // Updated to include optional genreId parameter
    public func execute(page: Int, genreId: Int?) -> AnyPublisher<[Movie], Error> {
        repository.fetchTrendingMovies(page: page, genreId: genreId)
    }
}
