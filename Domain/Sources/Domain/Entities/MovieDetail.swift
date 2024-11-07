//
//  MovieDetail.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//
import Foundation

/// Represents detailed information about a movie.
public struct MovieDetail: Identifiable, Decodable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let releaseDate: String?
    public let genres: [Genre]?
    public let overview: String?
    public let homepage: String?
    public let budget: Int?
    public let revenue: Int?
    public let spokenLanguages: [SpokenLanguage]?
    public let status: String?
    public let runtime: Int?
    public let backdropPath: String?
    public let voteCount: Int?
    public let tagline: String?
    public let belongsToCollection: MovieCollection?
    public let originalTitle: String?
    public let originalLanguage: String?
    public let originCountry: [String]?
    public let productionCountries: [ProductionCountry]?
    public let imdbID: String?
    public let video: Bool?
    public let popularity: Double?
    public let productionCompanies: [ProductionCompany]?
    public let adult: Bool?
    public let voteAverage: Double?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genres
        case overview
        case homepage
        case budget
        case revenue
        case spokenLanguages = "spoken_languages"
        case status
        case runtime
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case tagline
        case belongsToCollection = "belongs_to_collection"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case originCountry = "origin_country"
        case productionCountries = "production_countries"
        case imdbID = "imdb_id"
        case video
        case popularity
        case productionCompanies = "production_companies"
        case adult
        case voteAverage = "vote_average"
    }
}
