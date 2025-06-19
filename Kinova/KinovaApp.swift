//
//  KinovaApp.swift
//  Kinova
//
//  Created by Igor Camilo on 17.06.25.
//

import SwiftUI

@main
struct KinovaApp: App {
    @State private var client = KinovaClient()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(client)
    }
}
