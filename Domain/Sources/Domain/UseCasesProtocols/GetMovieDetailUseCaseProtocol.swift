//
//  GetMovieDetailUseCase.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Protocol defining the use case for fetching movie details.
public protocol GetMovieDetailUseCaseProtocol {
    /// Executes the use case to fetch movie details by ID.
    func execute(id: Int) -> AnyPublisher<MovieDetail, Error>
}

