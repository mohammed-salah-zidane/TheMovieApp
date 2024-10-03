//
//  MovieDetailRepositoryProtocol.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Protocol defining data operations for movie details.
public protocol MovieDetailRepositoryProtocol {
    /// Fetches detailed information about a movie by ID.
    func fetchMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error>
}
