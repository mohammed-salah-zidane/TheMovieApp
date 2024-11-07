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
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(
                            destination: buildDetailView(movie.id)
                        ) {
                            MovieRowView(movie: movie)
                        }
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentItem: movie)
                        }
                    }
                    if viewModel.isFetching {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("Trending Movies")
        }
    }
}
