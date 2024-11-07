//
//  MovieRowView.swift
//  Presentation
//
//  Created by Mohamed Salah on 03/10/2024.
//

import SwiftUI
import Domain

/// View representing a single movie row in the list.
public struct MovieRowView: View {
    public let movie: Movie

    public init(movie: Movie) {
        self.movie = movie
    }

    public var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(ImageConstants.imageBaseURL)\(movie.posterPath ?? "")")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseYear)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
