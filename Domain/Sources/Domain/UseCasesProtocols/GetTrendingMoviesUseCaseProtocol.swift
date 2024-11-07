//
//  GetTrendingMoviesUseCase.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//
import Combine

/// Protocol defining the use case for fetching trending movies.
public protocol GetTrendingMoviesUseCaseProtocol {
    /// Executes the use case to fetch trending movies for a given page and optional genre.
    func execute(page: Int, genreId: Int?) -> AnyPublisher<[Movie], Error>
}
