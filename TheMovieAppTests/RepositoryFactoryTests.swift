//
//  RepositoryFactoryTests.swift
//  Factories
//
//  Created by Mohamed Salah on 03/10/2024.
//
import XCTest
import Combine
@testable import Factories
@testable import Data
@testable import Domain

class MockRemoteDataSource: RemoteDataSourceProtocol {
    func fetchGenres() -> AnyPublisher<[Genre], Error> {
        return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func fetchTrendingMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func fetchMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        return Just(MovieDetail(
            id: id, title: "Mock Movie", posterPath: nil, releaseDate: nil,
            genres: nil, overview: nil, homepage: nil, budget: nil,
            revenue: nil, spokenLanguages: nil, status: nil, runtime: nil
        ))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

class RepositoryFactoryTests: XCTestCase {
    var repositoryFactory: RepositoryFactory!

    override func setUp() {
        super.setUp()
        let remoteDataSource = MockRemoteDataSource()
        repositoryFactory = RepositoryFactory(remoteDataSource: remoteDataSource)
    }

    func testCreateGenreRepository() {
        let genreRepository = repositoryFactory.createGenreRepository()
        XCTAssertNotNil(genreRepository)
    }

    func testCreateMovieRepository() {
        let movieRepository = repositoryFactory.createMovieRepository()
        XCTAssertNotNil(movieRepository)
    }

    func testCreateMovieDetailRepository() {
        let movieDetailRepository = repositoryFactory.createMovieDetailRepository()
        XCTAssertNotNil(movieDetailRepository)
    }
}
