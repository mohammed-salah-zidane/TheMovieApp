//
//  GetGenresUseCase.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Implementation of GetGenresUseCaseProtocol.
public class GetGenresUseCase: GetGenresUseCaseProtocol {
    private let repository: GenreRepositoryProtocol

    /// Initializes the use case with a genre repository.
    public init(repository: GenreRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() -> AnyPublisher<[Genre], Error> {
        repository.fetchGenres()
    }
}
