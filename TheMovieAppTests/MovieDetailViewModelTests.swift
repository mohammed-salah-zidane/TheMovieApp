//
//  MovieDetailViewModelTests.swift
//  Presentation
//
//  Created by Mohamed Salah on 03/10/2024.
//

import XCTest
import Combine
@testable import Presentation
@testable import Domain

class MockGetMovieDetailUseCase: GetMovieDetailUseCaseProtocol {
    func execute(id: Int) -> AnyPublisher<MovieDetail, Error> {
        let movieDetail = MovieDetail(
            id: id,
            title: "Test Movie",
            posterPath: nil,
            releaseDate: "2022-01-01",
            genres: [Genre(id: 1, name: "Action")],
            overview: "Test overview",
            homepage: "https://example.com",
            budget: 1000000,
            revenue: 2000000,
            spokenLanguages: [SpokenLanguage(iso_639_1: "en", name: "English")],
            status: "Released",
            runtime: 120
        )
        return Just(movieDetail)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class MovieDetailViewModelTests: XCTestCase {
    var viewModel: MovieDetailViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let getMovieDetailUseCase = MockGetMovieDetailUseCase()
        viewModel = MovieDetailViewModel(movieID: 1, getMovieDetailUseCase: getMovieDetailUseCase)
        cancellables = []
    }

    func testFetchMovieDetails() {
        let expectation = XCTestExpectation(description: "Fetch movie details")
        viewModel.$movieDetail
            .dropFirst()
            .sink { movieDetail in
                XCTAssertEqual(movieDetail?.title, "Test Movie")
                XCTAssertEqual(movieDetail?.runtime, 120)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
