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
    @Binding var selection: T?
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
                        Button {
                            selection = item
                        } label: {
#if os(tvOS)
                            PosterView(item: item)
#else
                            VStack { PosterView(item: item) }
#endif
                        }
                    }
                }
            }
            .scrollIndicators(.never)
            .scrollClipDisabled()
        }
        .buttonStyle(.borderless)
#if os(tvOS)
        .focusSection()
#endif
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

private struct PosterView<T: PosterProvider>: View {
    let item: T

    var body: some View {
        AsyncImage(url: item.posterURL) { image in
            image.resizable()
        } placeholder: {
            Color.secondary
        }
#if os(tvOS)
        .frame(width: 250, height: 375)
#else
        .frame(width: 180, height: 270)
#endif
        Text(item.title)
            .font(.caption)
            .multilineTextAlignment(.center)
#if os(tvOS)
            .frame(width: 250)
#else
            .frame(width: 180)
#endif
    }
}
