//
//  Movie.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Foundation

/// Represents a movie.
public struct Movie: Identifiable, Decodable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let releaseDate: String?
    public let genreIDs: [Int]?
    public let runtime: Int?
    public let status: String?
    public let backdropPath: String?
    public let overview: String?
    public let voteCount: Int?
    public let tagline: String?
    public let belongsToCollection: MovieCollection?
    public let originalTitle: String?
    public let originalLanguage: String?
    public let originCountry: [String]?
    public let productionCountries: [ProductionCountry]?
    public let homepage: String?
    public let revenue: Int?
    public let imdbID: String?
    public let video: Bool?
    public let budget: Int?
    public let popularity: Double?
    public let genres: [Genre]?
    public let productionCompanies: [ProductionCompany]?
    public let adult: Bool?
    public let spokenLanguages: [SpokenLanguage]?
    public let voteAverage: Double?

    public var releaseYear: String {
        guard let date = releaseDate else { return "N/A" }
        return String(date.prefix(4))
    }

    public init(
        id: Int,
        title: String,
        posterPath: String?,
        releaseDate: String?,
        genreIDs: [Int]?
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.genreIDs = genreIDs

        self.runtime = nil
        self.status = nil
        self.backdropPath = nil
        self.overview = nil
        self.voteCount = nil
        self.tagline = nil
        self.belongsToCollection = nil
        self.originalTitle = nil
        self.originalLanguage = nil
        self.originCountry = nil
        self.productionCountries = nil
        self.homepage = nil
        self.revenue = nil
        self.imdbID = nil
        self.video = nil
        self.budget = nil
        self.popularity = nil
        self.genres = nil
        self.productionCompanies = nil
        self.adult = nil
        self.spokenLanguages = nil
        self.voteAverage = nil
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case runtime
        case status
        case backdropPath = "backdrop_path"
        case overview
        case voteCount = "vote_count"
        case tagline
        case belongsToCollection = "belongs_to_collection"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case originCountry = "origin_country"
        case productionCountries = "production_countries"
        case homepage
        case revenue
        case imdbID = "imdb_id"
        case video
        case budget
        case popularity
        case genres
        case productionCompanies = "production_companies"
        case adult
        case spokenLanguages = "spoken_languages"
        case voteAverage = "vote_average"
    }
}

public struct MovieCollection: Decodable {}

public struct ProductionCountry: Decodable {
    public let name: String?
    public let iso3166_1: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case iso3166_1 = "iso_3166_1"
    }
}

public struct ProductionCompany: Decodable {
    public let logoPath: String?
    public let id: Int?
    public let originCountry: String?
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case id
        case originCountry = "origin_country"
        case name
    }
}

public struct SpokenLanguage: Decodable {
    public let englishName: String?
    public let name: String?
    public let iso639_1: String?

    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
        case iso639_1 = "iso_639_1"
    }
}
