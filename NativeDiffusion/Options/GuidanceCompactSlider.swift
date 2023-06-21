//
//  GuidanceCompactSlider.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import CompactSlider
import SwiftUI

struct GuidanceCompactSlider: View {
    @Binding var guidance: Double
    var body: some View {
        CompactSlider(value: $guidance, in: 0...25, step: 0.5) {
            LabeledContent {
                Text(String(format: "%.1f", guidance))
            } label: {
                Label("Prompt Guidance", systemImage: "text.redaction")
            }
        }
    }
}
