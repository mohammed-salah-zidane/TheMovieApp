//
//  MoviesListView.swift
//  TheMovieApp
//
//  Created by Mohamed Salah on 03/10/2024.
//

import SwiftUI
import Presentation
import Domain

/// View displaying a list of movies.
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
                contentView
            }
            .navigationTitle("Movies")
            .onAppear {
                viewModel.fetchInitialData()
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle:
            Spacer()
        case  .loading where viewModel.movies.isEmpty:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded, .loading:
            moviesList
        case .error(let message):
            VStack {
                Text("Error: \(message)")
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Retry") {
                    viewModel.fetchInitialData()
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var moviesList: some View {
        List {
            ForEach(viewModel.movies) { movie in
                NavigationLink(destination: buildDetailView(movie.id)) {
                    MovieRowView(movie: movie)
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentItem: movie)
                        }
                }
            }
            if viewModel.state == .loading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}
