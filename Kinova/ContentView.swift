//
//  ContentView.swift
//  Kinova
//
//  Created by Igor Camilo on 17.06.25.
//

import SwiftUI
import TMDb

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "film") {
                MoviesView()
            }
            Tab("TV Shows", systemImage: "tv") {
                TVShowsView()
            }
            Tab(role: .search) {
                SearchView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .frame(
            minWidth: 400,
            maxWidth: .infinity,
            minHeight: 300,
            maxHeight: .infinity
        )
    }
}

private let client = TMDbClient(apiKey: Secrets.tmdbAPIKey)

private struct MoviesView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    MovieListView(title: "Popular") {
                        try await client.movies.popular(
                            page: nil,
                            country: nil,
                            language: nil
                        )
                    }
                    MovieListView(title: "Now Playing") {
                        try await client.movies.nowPlaying(
                            page: nil,
                            country: nil,
                            language: nil
                        )
                    }
                    MovieListView(title: "Upcoming") {
                        try await client.movies.upcoming(
                            page: nil,
                            country: nil,
                            language: nil
                        )
                    }
                    MovieListView(title: "Now Playing") {
                        try await client.movies.nowPlaying(
                            page: nil,
                            country: nil,
                            language: nil
                        )
                    }
                }
            }
            .navigationTitle("Movies")
        }
    }
}

private struct MovieListView: View {
    let title: LocalizedStringKey
    let task: () async throws -> MoviePageableList

    @State private var movies: [MovieListItem] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding([.top, .horizontal])
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(movies) { movie in
                        Text(movie.title)
                            .frame(width: 100, height: 150)
                            .background(Color.secondary)
                    }
                }
            }
            .scrollIndicators(.never)
        }
        .task {
            do {
                movies = try await task().results
            } catch {
                print("MoviesView", error)
            }
        }
    }
}

private struct TVShowsView: View {
    @State private var tvShows: [TVSeriesListItem] = []

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    TVShowListView(title: "Popular") {
                        try await client.tvSeries.popular(
                            page: nil,
                            language: nil
                        )
                    }
                }
            }
            .navigationTitle("TV Shows")
        }
    }
}

private struct TVShowListView: View {
    let title: LocalizedStringKey
    let task: () async throws -> TVSeriesPageableList

    @State private var tvShows: [TVSeriesListItem] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding([.top, .horizontal])
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(tvShows) { tvShow in
                        Text(tvShow.name)
                            .frame(width: 100, height: 150)
                            .background(Color.secondary)
                    }
                }
            }
            .scrollIndicators(.never)
        }
        .task {
            do {
                tvShows = try await task().results
            } catch {
                print("TVShowListView", error)
            }
        }
    }
}

private struct SearchView: View {
    var body: some View {
        NavigationStack {
            List(1..<100, id: \.self) { index in
                Text("Result \(index)")
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    ContentView()
}
