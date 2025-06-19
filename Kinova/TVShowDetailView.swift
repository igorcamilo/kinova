//
//  TVShowDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 19.06.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//


import SwiftUI

struct TVShowDetailView: View {
    let id: TVShow.ID

    var body: some View {
        Text("TV Show \(id.rawValue)")
            .navigationTitle("TV Show Detail")
    }
}
