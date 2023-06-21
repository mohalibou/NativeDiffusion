//
//  SchedulerPicker.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import StableDiffusion
import SwiftUI

struct SchedulerPicker: View {
    
    @Binding var scheduler: StableDiffusionScheduler
    
    var body: some View {
        Picker("Scheduler", selection: $scheduler) {
            Text("DPM-Solver++").tag(StableDiffusionScheduler.dpmSolverMultistepScheduler)
            Text("PNDM").tag(StableDiffusionScheduler.pndmScheduler)
        }
        .foregroundColor(.secondary)
        .padding(.leading, 6)
    }
}
