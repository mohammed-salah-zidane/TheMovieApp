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
    public let searchMoviesUseCase: SearchMoviesUseCaseProtocol // Add this line
    public var cancellables = Set<AnyCancellable>()
    public var currentPage = 1
    public var isFetching = false
    private var isSearchMode = false // Add this line

    /// Initializes the view model with the required use cases.
    public init(getGenresUseCase: GetGenresUseCaseProtocol,
                getTrendingMoviesUseCase: GetTrendingMoviesUseCaseProtocol,
                searchMoviesUseCase: SearchMoviesUseCaseProtocol) { // Update init
        self.getGenresUseCase = getGenresUseCase
        self.getTrendingMoviesUseCase = getTrendingMoviesUseCase
        self.searchMoviesUseCase = searchMoviesUseCase // Add this line
        fetchGenres()
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

    /// Fetches movies based on search text and selected genres.
    private func fetchMovies() {
        guard !isFetching else { return }
        isFetching = true

        let publisher: AnyPublisher<[Movie], Error>
        if isSearchMode {
            publisher = searchMoviesUseCase.execute(query: searchText, page: currentPage)
        } else {
            publisher = getTrendingMoviesUseCase.execute(page: currentPage, genreId: selectedGenres.first)
        }

        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                if case .failure(let error) = completion {
                    print("Error fetching movies: \(error)")
                }
            }, receiveValue: { [weak self] newMovies in
                if self?.currentPage == 1 {
                    self?.movies = newMovies
                } else {
                    self?.movies.append(contentsOf: newMovies)
                }
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }

    /// Sets up search functionality with debounce.
    private func setupSearch() {
        Publishers.CombineLatest($searchText, $selectedGenres)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText, selectedGenres in
                self?.currentPage = 1
                self?.isSearchMode = !searchText.isEmpty
                self?.fetchMovies()
            }
            .store(in: &cancellables)
    }

    /// Loads more movies when reaching the end of the list.
    public func loadMoreIfNeeded(currentItem: Movie?) {
        guard let currentItem = currentItem, !isFetching else { return }
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            fetchMovies()
        }
    }
}
