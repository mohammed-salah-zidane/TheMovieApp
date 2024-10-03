//
//  MovieDetailView.swift
//  TheMovieApp
//
//  Created by Mohamed Salah on 03/10/2024.
//

import SwiftUI
import Presentation
import Domain

/// View displaying detailed information about a movie.
struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel

    /// Initializes the view with a MovieDetailViewModel.
    init(viewModel: MovieDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            if let movie = viewModel.movieDetail {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: "\(ImageConstants.imageBaseURL)\(movie.posterPath ?? "")")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 300)
                    .cornerRadius(8)

                    Text(movie.title)
                        .font(.title)
                        .bold()

                    Text("Release Date: \(movie.releaseDate ?? "N/A")")
                    Text("Genres: \(movie.genres?.map { $0.name }.joined(separator: ", ") ?? "N/A")")
                    Text("Overview: \(movie.overview ?? "N/A")")
                    Text("Homepage: \(movie.homepage ?? "N/A")")
                    Text("Budget: $\(movie.budget ?? 0)")
                    Text("Revenue: $\(movie.revenue ?? 0)")
                    Text("Spoken Languages: \(movie.spokenLanguages?.map { $0.name }.joined(separator: ", ") ?? "N/A")")
                    Text("Status: \(movie.status ?? "N/A")")
                    Text("Runtime: \(movie.runtime ?? 0) mins")
                }
                .padding()
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchMovieDetails()
                    }
            }
        }
        .navigationTitle("Movie Details")
    }
}
