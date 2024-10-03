//
//  GenreRepositoryProtocol.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Protocol defining data operations for genres.
public protocol GenreRepositoryProtocol {
    /// Fetches a list of genres.
    func fetchGenres() -> AnyPublisher<[Genre], Error>
}
