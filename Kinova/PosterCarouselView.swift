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
                LazyHStack(alignment: .top) {
                    ForEach(list) { item in
                        NavigationLink(value: item.id) {
                            VStack {
                                AsyncImage(url: item.posterURL)
                                Text(item.title).font(.caption)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 185)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .scrollIndicators(.never)
            .scrollClipDisabled()
        }
        .task {
            do {
                list = try await task()
            } catch URLError.cancelled {
                // Do nothing
            } catch {
                print("MoviesView", error)
            }
        }
    }
}
