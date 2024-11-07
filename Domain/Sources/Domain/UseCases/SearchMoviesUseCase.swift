//
//  SearchMoviesUseCase.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Implementation of SearchMoviesUseCaseProtocol.
public class SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    private let repository: MovieRepositoryProtocol

    /// Initializes the use case with a movie repository.
    public init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(query: String, page: Int) -> AnyPublisher<[Movie], Error> {
        repository.searchMovies(query: query, page: page)
    }
}
