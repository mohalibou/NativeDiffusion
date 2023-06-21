//
//  ConfigurationPicker.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import CoreML
import SwiftUI

struct ConfigurationPicker: View {
    @Binding var configuration: MLComputeUnits
    var body: some View {
        Picker("Configuration", selection: $configuration) {
            Text("GPU").tag(MLComputeUnits.cpuAndGPU)
            Text("Neural Engine").tag(MLComputeUnits.cpuAndNeuralEngine)
            Text("GPU & Neural Engine").tag(MLComputeUnits.all)
        }
        .foregroundColor(.secondary)
        .padding(.leading, 6)
    }
}
