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

    public init(
        id: Int,
        title: String,
        posterPath: String?,
        releaseDate: String?,
        genres: [Genre]?,
        overview: String?,
        homepage: String?,
        budget: Int?,
        revenue: Int?,
        spokenLanguages: [SpokenLanguage]?,
        status: String?,
        runtime: Int?
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.genres = genres
        self.overview = overview
        self.homepage = homepage
        self.budget = budget
        self.revenue = revenue
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.runtime = runtime
    }
}

/// Represents a spoken language in a movie.
public struct SpokenLanguage: Decodable {
    public let iso_639_1: String
    public let name: String

    public init(iso_639_1: String, name: String) {
        self.iso_639_1 = iso_639_1
        self.name = name
    }
}
