//
//  NumberOfImagesCompactSlider.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import SwiftUI
import CompactSlider

struct NumberOfImagesCompactSlider: View {
    @Binding var numberOfImages: Double
    var body: some View {
        CompactSlider(value: $numberOfImages, in: 1...6, step: 1) {
            LabeledContent {
                Text(String(format: "%.0f", numberOfImages))
            } label: {
                Label("Number of Images", systemImage: "photo.stack")
            }
        }
    }
}
