//
//  GenreChipsView.swift
//  Presentation
//
//  Created by Mohamed Salah on 03/10/2024.
//

import SwiftUI
import Domain

/// View displaying genre chips for filtering.
public struct GenreChipsView: View {
    public let genres: [Genre]
    @Binding public var selectedGenres: Set<Int>

    public init(genres: [Genre], selectedGenres: Binding<Set<Int>>) {
        self.genres = genres
        self._selectedGenres = selectedGenres
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres) { genre in
                    GenreChip(genre: genre, isSelected: selectedGenres.contains(genre.id)) {
                        if selectedGenres.contains(genre.id) {
                            selectedGenres.remove(genre.id)
                        } else {
                            selectedGenres.insert(genre.id)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

/// View representing a single genre chip.
public struct GenreChip: View {
    public let genre: Genre
    public let isSelected: Bool
    public let action: () -> Void

    public init(genre: Genre, isSelected: Bool, action: @escaping () -> Void) {
        self.genre = genre
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(genre.name)
                .padding(8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(16)
        }
    }
}

