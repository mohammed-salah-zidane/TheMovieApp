//
//  SearchBar.swift
//  Presentation
//
//  Created by Mohamed Salah on 03/10/2024.
//

import SwiftUI

/// View representing a search bar.
public struct SearchBar: View {
    @Binding public var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    public var body: some View {
        TextField("Search...", text: $text)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
