//
//  MovieRepositoryProtocol.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine

/// Protocol defining data operations for movies.
public protocol MovieRepositoryProtocol {
    /// Fetches a list of trending movies for a given page and optional genre.
    func fetchTrendingMovies(page: Int, genreId: Int?) -> AnyPublisher<[Movie], Error>

    /// Searches for movies based on a query string.
    func searchMovies(query: String, page: Int) -> AnyPublisher<[Movie], Error>
}
