//
//  SearchMoviesUseCaseProtocol.swift
//  Domain
//
//  Created by Mohamed Salah on 05/11/2024.
//

import Foundation
import Combine

/// Protocol defining the use case for searching movies.
public protocol SearchMoviesUseCaseProtocol {
    /// Executes the use case to search movies based on a query string and page number.
    func execute(query: String, page: Int) -> AnyPublisher<[Movie], Error>
}
