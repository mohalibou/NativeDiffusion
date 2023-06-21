//
//  NativeDiffusionApp.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 5/23/23.
//

import SwiftUI

@main
struct NativeDiffusionApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
                .modelContainer(for: [GeneratedImage.self])
        }
    }
}
