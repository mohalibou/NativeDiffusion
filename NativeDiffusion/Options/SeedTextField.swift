//
//  SeedTextField.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import Combine
import CompactSlider
import SwiftUI

struct SeedTextField: View {
    @Binding var seed: String
    var body: some View {
        LabeledContent {
            TextField("Seed", text: $seed, axis: .vertical)
                .padding(4)
                .background(Color.secondary.opacity(0.28))
                .cornerRadius(4)
                .onReceive(Just(seed)) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count > 10 {
                        seed = String(filtered.prefix(10)) // 4294967295 highest possible seed
                    } else {
                        seed = filtered
                    }
                }
        } label: {
            Label("Seed", systemImage: "leaf")
                .foregroundColor(.secondary)
                .padding(.leading, 6)
        }
    }
    
}
