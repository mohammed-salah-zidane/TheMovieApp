//
//  MovieDetailViewModel.swift
//  Presentation
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Foundation
import Combine
import Domain

/// ViewModel for the movie detail view.
public class MovieDetailViewModel: ObservableObject {
    @Published public private(set) var movieDetail: MovieDetail?

    private let getMovieDetailUseCase: GetMovieDetailUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private let movieID: Int

    /// Initializes the view model with the required use case and movie ID.
    public init(movieID: Int, getMovieDetailUseCase: GetMovieDetailUseCaseProtocol) {
        self.movieID = movieID
        self.getMovieDetailUseCase = getMovieDetailUseCase
        fetchMovieDetails()
    }

    /// Fetches the movie details.
    public func fetchMovieDetails() {
        getMovieDetailUseCase.execute(id: movieID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] detail in
                self?.movieDetail = detail
            })
            .store(in: &cancellables)
    }
}
