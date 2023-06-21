//
//  StepsCompactSlider.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import CompactSlider
import SwiftUI

struct StepsCompactSlider: View {
    @Binding var steps: Double
    var body: some View {
        CompactSlider(value: $steps, in: 1...150, step: 1) {
            LabeledContent {
                Text(String(format: "%.0f", steps))
            } label: {
                Label("Steps", systemImage: "stairs")
            }
        }
    }
}
