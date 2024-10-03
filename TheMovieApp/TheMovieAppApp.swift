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
    var body: some Scene {
        WindowGroup {
            // Network Client
            let networkClient = NetworkClient()
            
            // Remote Data Source
            let remoteDataSource = RemoteDataSource(networkClient: networkClient)
            
            // Repository Factory
            let repositoryFactory = RepositoryFactory(remoteDataSource: remoteDataSource)
            
            // Use Case Factory
            let useCaseFactory = UseCaseFactory(repositoryFactory: repositoryFactory)
            
            // View Models
            let moviesViewModel = MoviesViewModel(
                getGenresUseCase: useCaseFactory.createGetGenresUseCase(),
                getTrendingMoviesUseCase: useCaseFactory.createGetTrendingMoviesUseCase()
            )
            
            // Main View
            MoviesListView(viewModel: moviesViewModel) { movieID in
                // Build and present the MovieDetailView
                let movieDetailViewModel = MovieDetailViewModel(
                    movieID: movieID,
                    getMovieDetailUseCase: useCaseFactory.createGetMovieDetailUseCase()
                )
                return MovieDetailView(viewModel: movieDetailViewModel)
            }
        }
    }
}
