//
//  GetTrendingMoviesUseCaseTests.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//

import XCTest
import Combine
@testable import Domain

class MockMovieRepository: MovieRepositoryProtocol {
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        let movies = [Movie(id: 1, title: "Mock Movie", posterPath: nil, releaseDate: "2022", genreIDs: [1])]
        return Just(movies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class GetTrendingMoviesUseCaseTests: XCTestCase {
    var useCase: GetTrendingMoviesUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let repository = MockMovieRepository()
        useCase = GetTrendingMoviesUseCase(repository: repository)
        cancellables = []
    }

    func testExecuteFetchesTrendingMovies() {
        let expectation = XCTestExpectation(description: "Fetch trending movies")
        useCase.execute(page: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { movies in
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Mock Movie")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
