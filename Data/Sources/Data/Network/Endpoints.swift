//
//  Endpoints.swift
//  Data
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Foundation

/// Enum containing API endpoints.
public enum Endpoints {
    case genres
    case trendingMovies(page: Int)
    case movieDetail(id: Int)

    /// Returns the full URL for the endpoint.
    public var url: String {
        switch self {
        case .genres:
            return "\(APIConstants.baseURL)/genre/movie/list?api_key=\(APIConstants.apiKey)"
        case .trendingMovies(let page):
            return "\(APIConstants.baseURL)/discover/movie?include_adult=false&sort_by=popularity.desc&page=\(page)&api_key=\(APIConstants.apiKey)"
        case .movieDetail(let id):
            return "\(APIConstants.baseURL)/movie/\(id)?api_key=\(APIConstants.apiKey)"
        }
    }
}
