//
//  TheMovieAppApp.swift
//  TheMovieApp
//
//  Created by Mohamed Salah on 03/10/2024.
//

import SwiftUI
import Presentation
import Data
import Domain
import Factories

@main
struct TheMovieAppApp: App {
    let viewModelBuilder: MovieViewModelsBuilder
    var movieViewModel: MoviesViewModel
    
    init() {
        // Construct the ViewModelBuilder using the Builder pattern
        viewModelBuilder = MovieViewModelsBuilder()
            .setNetworkClient()
            .setRemoteDataSource()
            .setRepositoryFactory()
            .setUseCaseFactory()
        movieViewModel = viewModelBuilder.buildMoviesViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            MoviesListView(viewModel: movieViewModel) { movieID in
                let movieDetailViewModel = viewModelBuilder.buildMovieDetailViewModel(movieID: movieID)
                return MovieDetailView(viewModel: movieDetailViewModel)
            }
        }
    }
}
