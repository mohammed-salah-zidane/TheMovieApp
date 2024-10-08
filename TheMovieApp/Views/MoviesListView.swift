//
//  MoviesListView.swift
//  TheMovieApp
//
//  Created by Mohamed Salah on 03/10/2024.
//

import SwiftUI
import Presentation
import Domain

/// View displaying a list of trending movies.
struct MoviesListView<DetailView: View>: View {
    @StateObject private var viewModel: MoviesViewModel
    private let buildDetailView: (Int) -> DetailView

    /// Initializes the view with a MoviesViewModel and a closure to build the detail view.
    init(viewModel: MoviesViewModel, buildDetailView: @escaping (Int) -> DetailView) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.buildDetailView = buildDetailView
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                GenreChipsView(genres: viewModel.genres, selectedGenres: $viewModel.selectedGenres)
                List {
                    ForEach(viewModel.filteredMovies) { movie in
                        NavigationLink(
                            destination: buildDetailView(movie.id)
                        ) {
                            MovieRowView(movie: movie)
                        }
                    }
                    if viewModel.filteredMovies.isEmpty && viewModel.isFetching {
                        ProgressView()
                            .onAppear {
                                viewModel.fetchMovies()
                            }
                    }
                }
            }
            .navigationTitle("Trending Movies")
            .onAppear {
                if viewModel.movies.isEmpty {
                    viewModel.fetchMovies()
                }
            }
        }
    }
}
