//
//  MovieRepositoryProtocol.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Protocol defining data operations for movies.
public protocol MovieRepositoryProtocol {
    /// Fetches a list of trending movies for a given page.
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[Movie], Error>
}
