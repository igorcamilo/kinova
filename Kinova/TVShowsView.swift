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
    @State private var selctedTVShow: TVShow?

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    PosterCarouselView(title: "Popular", selection: $selctedTVShow) {
                        try await client.popularTVShows()
                    }
                    PosterCarouselView(title: "Airing Today", selection: $selctedTVShow) {
                        try await client.airingTodayTVShows()
                    }
                    PosterCarouselView(title: "On TV", selection: $selctedTVShow) {
                        try await client.onTheAirTVShows()
                    }
                    PosterCarouselView(title: "Top Rated", selection: $selctedTVShow) {
                        try await client.topRatedTVShows()
                    }
                }
            }
#if !os(tvOS)
            .navigationTitle("TV Shows")
#endif
            .navigationDestination(item: $selctedTVShow) { tvShow in
                TVShowDetailView(tvShow: tvShow)
            }
        }
    }
}
