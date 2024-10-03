//
//  GetGenresUseCase.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Protocol defining the use case for fetching genres.
public protocol GetGenresUseCaseProtocol {
    /// Executes the use case to fetch genres.
    func execute() -> AnyPublisher<[Genre], Error>
}

