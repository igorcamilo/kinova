//
//  PosterCarouselView.swift
//  Kinova
//
//  Created by Igor Camilo on 19.06.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//

import SwiftUI

struct PosterCarouselView<T: PosterProvider>: View {
    let title: LocalizedStringKey
    let task: () async throws -> [T]

    @State private var list: [T] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding([.top, .horizontal])
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(list) { item in
                        AsyncImage(url: item.posterURL)
                            .frame(width: 185, height: 278)
                    }
                }
            }
            .scrollIndicators(.never)
        }
        .task {
            do {
                list = try await task()
            } catch {
                print("MoviesView", error)
            }
        }
    }
}
