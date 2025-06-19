//
//  TVShowDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 19.06.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//


import SwiftUI

struct TVShowDetailView: View {
    let tvShow: TVShow

    var body: some View {
        Text("TV Show \(tvShow.id)")
            .navigationTitle(tvShow.title)
    }
}
