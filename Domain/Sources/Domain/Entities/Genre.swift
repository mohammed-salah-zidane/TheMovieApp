//
//  Genre.swift
//  Domain
//
//  Created by Mohamed Salah on 03/10/2024.
//

import Foundation

/// Represents a movie genre.
public struct Genre: Identifiable, Decodable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
