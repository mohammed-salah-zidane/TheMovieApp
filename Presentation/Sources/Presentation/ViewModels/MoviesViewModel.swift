//
//  MoviesViewModel.swift
//  Presentation
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Foundation
import Combine
import Domain

/// ViewModel for the movies list view.
public class MoviesViewModel: ObservableObject {
    @Published public private(set) var movies: [Movie] = []
    @Published public private(set) var genres: [Genre] = []
    @Published public var searchText: String = ""
    @Published public var selectedGenres: Set<Int> = []

    public let getGenresUseCase: GetGenresUseCaseProtocol
    public let getTrendingMoviesUseCase: GetTrendingMoviesUseCaseProtocol
    public var cancellables = Set<AnyCancellable>()
    public var currentPage = 1
    public var isFetching = false

    /// Initializes the view model with the required use cases.
    public init(getGenresUseCase: GetGenresUseCaseProtocol,
                getTrendingMoviesUseCase: GetTrendingMoviesUseCaseProtocol) {
        self.getGenresUseCase = getGenresUseCase
        self.getTrendingMoviesUseCase = getTrendingMoviesUseCase
        fetchGenres()
        fetchMovies()
        setupSearch()
    }

    /// Fetches the list of genres.
    private func fetchGenres() {
        getGenresUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] genres in
                self?.genres = genres
            })
            .store(in: &cancellables)
    }

    /// Fetches the list of trending movies with pagination support.
    public func fetchMovies() {
        guard !isFetching else { return }
        isFetching = true

        getTrendingMoviesUseCase.execute(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.isFetching = false
            }, receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies)
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }

    /// Sets up search functionality with debounce.
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { _ in }
            .store(in: &cancellables)
    }

    /// Computes the filtered list of movies based on search text and selected genres.
    public var filteredMovies: [Movie] {
        movies.filter { movie in
            let matchesSearch = searchText.isEmpty || movie.title.lowercased().contains(searchText.lowercased())
            let matchesGenre = selectedGenres.isEmpty || !(Set(movie.genreIDs ?? []).isDisjoint(with: selectedGenres))
            return matchesSearch && matchesGenre
        }
    }
}
