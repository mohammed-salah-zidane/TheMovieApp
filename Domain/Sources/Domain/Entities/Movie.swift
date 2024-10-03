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

    /// Returns the release year extracted from the release date.
    public var releaseYear: String {
        guard let date = releaseDate else { return "N/A" }
        return String(date.prefix(4))
    }

    public init(id: Int, title: String, posterPath: String?, releaseDate: String?, genreIDs: [Int]?) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.genreIDs = genreIDs
    }
}

