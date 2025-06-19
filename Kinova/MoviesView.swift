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

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    PosterCarouselView(title: "Popular") {
                        try await client.popularMovies()
                    }
                    PosterCarouselView(title: "Now Playing") {
                        try await client.nowPlayingMovies()
                    }
                    PosterCarouselView(title: "Upcoming") {
                        try await client.upcomingMovies()
                    }
                    PosterCarouselView(title: "Top Rated") {
                        try await client.topRatedMovies()
                    }
                }
            }
            .navigationTitle("Movies")
        }
    }
}
