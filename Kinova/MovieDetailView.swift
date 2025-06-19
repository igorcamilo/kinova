//
//  MovieDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 19.06.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    let id: Movie.ID

    var body: some View {
        Text("Movie \(id.rawValue)")
            .navigationTitle("Movie Detail")
    }
}
