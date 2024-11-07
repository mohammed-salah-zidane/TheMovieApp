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
    // Updated to include optional genreId parameter
    func fetchTrendingMovies(page: Int, genreId: Int?) -> AnyPublisher<[Movie], Error> {
        let movies = [Movie(id: 1, title: "Mock Movie", posterPath: nil, releaseDate: "2022", genreIDs: [1])]
        return Just(movies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Added search function to conform to MovieRepositoryProtocol
    func searchMovies(query: String, page: Int) -> AnyPublisher<[Movie], Error> {
        // Implementation not needed for this test
        return Fail(error: NSError(domain: "", code: 0, userInfo: nil)).eraseToAnyPublisher()
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
        // Updated to include nil for genreId
        useCase.execute(page: 1, genreId: nil)
            .sink(receiveCompletion: { _ in }, receiveValue: { movies in
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Mock Movie")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }

    // Added test for fetching trending movies with a specific genre
    func testExecuteFetchesTrendingMoviesWithGenre() {
        let expectation = XCTestExpectation(description: "Fetch trending movies with genre")
        useCase.execute(page: 1, genreId: 28) // 28 is the genre ID for Action movies
            .sink(receiveCompletion: { _ in }, receiveValue: { movies in
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Mock Movie")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
