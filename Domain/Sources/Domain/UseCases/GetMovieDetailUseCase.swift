//
//  GetMovieDetailUseCase.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Implementation of GetMovieDetailUseCaseProtocol.
public class GetMovieDetailUseCase: GetMovieDetailUseCaseProtocol {
    private let repository: MovieDetailRepositoryProtocol

    /// Initializes the use case with a movie detail repository.
    public init(repository: MovieDetailRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(id: Int) -> AnyPublisher<MovieDetail, Error> {
        repository.fetchMovieDetail(id: id)
    }
}
