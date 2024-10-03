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
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[Movie], Error>
    func fetchMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error>
}
