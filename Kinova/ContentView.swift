//
//  ContentView.swift
//  Kinova
//
//  Created by Igor Camilo on 17.06.25.
//

import SwiftUI

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
