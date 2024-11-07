//
//  MovieViewModelsBuilder.swift
//  Factories
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Presentation
import Data
import Factories
import Domain

/// A standard Builder for creating ViewModel instances with proper dependencies
final class MovieViewModelsBuilder {
    private var networkClient: NetworkClient?
    private var remoteDataSource: RemoteDataSource?
    private var repositoryFactory: RepositoryFactory?
    private var useCaseFactory: UseCaseFactory?
    
    func setNetworkClient() -> MovieViewModelsBuilder {
        self.networkClient = NetworkClient()
        return self
    }
    
    func setRemoteDataSource() -> MovieViewModelsBuilder {
        guard let networkClient = networkClient else {
            fatalError("NetworkClient must be set before RemoteDataSource")
        }
        self.remoteDataSource = RemoteDataSource(networkClient: networkClient)
        return self
    }
    
    func setRepositoryFactory() -> MovieViewModelsBuilder {
        guard let remoteDataSource = remoteDataSource else {
            fatalError("RemoteDataSource must be set before RepositoryFactory")
        }
        self.repositoryFactory = RepositoryFactory(remoteDataSource: remoteDataSource)
        return self
    }
    
    func setUseCaseFactory() -> MovieViewModelsBuilder {
        guard let repositoryFactory = repositoryFactory else {
            fatalError("RepositoryFactory must be set before UseCaseFactory")
        }
        self.useCaseFactory = UseCaseFactory(repositoryFactory: repositoryFactory)
        return self
    }
    
    func buildMoviesViewModel() -> MoviesViewModel {
        guard let useCaseFactory = useCaseFactory else {
            fatalError("UseCaseFactory must be set before creating MoviesViewModel")
        }
        return MoviesViewModel(
            getGenresUseCase: useCaseFactory.createGetGenresUseCase(),
            getTrendingMoviesUseCase: useCaseFactory.createGetTrendingMoviesUseCase(),
            searchMoviesUseCase: useCaseFactory.createSearchMoviesUseCase()
        )
    }
    
    func buildMovieDetailViewModel(movieID: Int) -> MovieDetailViewModel {
        guard let useCaseFactory = useCaseFactory else {
            fatalError("UseCaseFactory must be set before creating MovieDetailViewModel")
        }
        return MovieDetailViewModel(
            movieID: movieID,
            getMovieDetailUseCase: useCaseFactory.createGetMovieDetailUseCase()
        )
    }
}
