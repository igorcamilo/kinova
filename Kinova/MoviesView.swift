//
//  MoviesView.swift
//  Kinova
//
//  Created by Igor Camilo on 19.06.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//

import SwiftUI

struct MoviesView: View {
    @Environment(KinovaClient.self) private var client
    @State private var selectedMovie: Movie?

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    PosterCarouselView(title: "Popular", selection: $selectedMovie) {
                        try await client.popularMovies()
                    }
                    PosterCarouselView(title: "Now Playing", selection: $selectedMovie) {
                        try await client.nowPlayingMovies()
                    }
                    PosterCarouselView(title: "Upcoming", selection: $selectedMovie) {
                        try await client.upcomingMovies()
                    }
                    PosterCarouselView(title: "Top Rated", selection: $selectedMovie) {
                        try await client.topRatedMovies()
                    }
                }
            }
#if !os(tvOS)
            .navigationTitle("Movies")
#endif
            .navigationDestination(item: $selectedMovie) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}
