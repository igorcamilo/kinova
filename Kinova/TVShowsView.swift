//
//  TVShowsView.swift
//  Kinova
//
//  Created by Igor Camilo on 19.06.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//

import SwiftUI

struct TVShowsView: View {
    @Environment(KinovaClient.self) private var client

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    PosterCarouselView(title: "Popular") {
                        try await client.popularTVShows()
                    }
                    PosterCarouselView(title: "Airing Today") {
                        try await client.airingTodayTVShows()
                    }
                    PosterCarouselView(title: "On TV") {
                        try await client.onTheAirTVShows()
                    }
                    PosterCarouselView(title: "Top Rated") {
                        try await client.topRatedTVShows()
                    }
                }
            }
#if !os(tvOS)
            .navigationTitle("TV Shows")
#endif
            .navigationDestination(for: Movie.ID.self) { id in
                MovieDetailView(id: id)
            }
            .navigationDestination(for: TVShow.ID.self) { id in
                TVShowDetailView(id: id)
            }
        }
    }
}
