//
//  GetMovieDetailUseCaseTests.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//
import XCTest
import Combine
@testable import Domain

class MockMovieDetailRepository: MovieDetailRepositoryProtocol {
    func fetchMovieDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        let movieDetail = MovieDetail(
            id: id,
            title: "Mock Movie",
            posterPath: nil,
            releaseDate: "2022",
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

class GetMovieDetailUseCaseTests: XCTestCase {
    var useCase: GetMovieDetailUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let repository = MockMovieDetailRepository()
        useCase = GetMovieDetailUseCase(repository: repository)
        cancellables = []
    }

    func testExecuteFetchesMovieDetail() {
        let expectation = XCTestExpectation(description: "Fetch movie details")
        useCase.execute(id: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { movieDetail in
                XCTAssertEqual(movieDetail.title, "Mock Movie")
                XCTAssertEqual(movieDetail.runtime, 120)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
