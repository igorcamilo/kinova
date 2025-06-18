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
    @State private var movies: [MovieListItem] = []

    var body: some View {
        NavigationStack {
            List(movies) { movie in
                Text(movie.title)
            }
            .navigationTitle("Movies")
        }
        .task {
            do {
                let response = try await client.movies.nowPlaying(
                    page: nil,
                    country: nil,
                    language: nil
                )
                movies = response.results
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
            List(tvShows) { tvShow in
                Text(tvShow.name)
            }
            .navigationTitle("TV Shows")
        }
        .task {
            do {
                let response = try await client.tvSeries.popular(
                    page: nil,
                    language: nil
                )
                tvShows = response.results
            } catch {
                print("TVShowsView", error)
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
