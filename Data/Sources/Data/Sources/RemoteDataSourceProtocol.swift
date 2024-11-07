//
//  RemoteDataSourceProtocol.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Combine
import Domain

/// Protocol defining methods for remote data fetching.
public protocol RemoteDataSourceProtocol {
    func fetchGenres() -> AnyPublisher<[Genre], Error>
    // Updated to include optional genreId parameter
    func fetchTrendingMovies(page: Int, genreId: Int?) -> AnyPublisher<[Movie], Error>
    func fetchMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error>
    // Added search function
    func searchMovies(query: String, page: Int) -> AnyPublisher<[Movie], Error>
}
