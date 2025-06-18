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
                PlaceholderView("Movies") { index in
                    Label("Movie \(index)", systemImage: "film")
                }
            }
            Tab("TV Shows", systemImage: "tv") {
                PlaceholderView("TV Shows") { index in
                    Label("TV Show \(index)", systemImage: "tv")
                }
            }
            Tab(role: .search) {
                PlaceholderView("Search") { index in
                    Label("Search \(index)", systemImage: "magnifyingglass")
                }
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

private struct PlaceholderView<RowContent: View>: View {
    var title: LocalizedStringKey
    var rowContent: (_ index: Int) -> RowContent

    init(
        _ title: LocalizedStringKey,
        @ViewBuilder rowContent: @escaping (_ index: Int) -> RowContent
    ) {
        self.title = title
        self.rowContent = rowContent
    }

    var body: some View {
        NavigationStack {
            List(1..<100, id: \.self) { index in
                rowContent(index)
            }
            .navigationTitle(title)
        }
    }
}

#Preview {
    ContentView()
}
