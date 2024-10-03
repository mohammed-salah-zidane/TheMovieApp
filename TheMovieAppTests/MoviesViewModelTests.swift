//
//  MoviesViewModelTests.swift
//  Presentation
//
//  Created by Mohamed Salah on 03/10/2024.
//

import XCTest
import Combine
@testable import Presentation
@testable import Domain

class MockGetGenresUseCase: GetGenresUseCaseProtocol {
    func execute() -> AnyPublisher<[Genre], Error> {
        Just([Genre(id: 1, name: "Action"), Genre(id: 2, name: "Comedy")])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class MockGetTrendingMoviesUseCase: GetTrendingMoviesUseCaseProtocol {
    func execute(page: Int) -> AnyPublisher<[Movie], Error> {
        let movies = [Movie(id: 1, title: "Test Movie", posterPath: nil, releaseDate: "2022-01-01", genreIDs: [1])]
        return Just(movies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class MoviesViewModelTests: XCTestCase {
    var viewModel: MoviesViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let getGenresUseCase = MockGetGenresUseCase()
        let getTrendingMoviesUseCase = MockGetTrendingMoviesUseCase()
        viewModel = MoviesViewModel(getGenresUseCase: getGenresUseCase, getTrendingMoviesUseCase: getTrendingMoviesUseCase)
        cancellables = []
    }

    func testFetchGenres() {
        let expectation = XCTestExpectation(description: "Fetch genres")
        viewModel.$genres
            .dropFirst()
            .sink { genres in
                XCTAssertEqual(genres.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }

    func testFetchMovies() {
        let expectation = XCTestExpectation(description: "Fetch movies")
        viewModel.$movies
            .dropFirst()
            .sink { movies in
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Test Movie")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
