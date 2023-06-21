//
//  SidebarView.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 5/23/23.
//

import SwiftUI
import StableDiffusion
import CompactSlider
import Combine
import CoreML

struct OptionsView: View {
    
    @ObservedObject var vm: AppViewModel
    
    @State private var image: NSImage?
    
    @State private var model: URL?
    
    var body: some View {
        VStack {
            Label("Generation Options", systemImage: "gearshape.2").bold()
            Divider()
            List {
                Section(header: Label("Model/Scheduler", systemImage: "cpu")) {
                    //ModelPicker()
                    SchedulerPicker(scheduler: $vm.scheduler)
                    ConfigurationPicker(configuration: $vm.configuration)
                    
                }
                
                Section(header: Label("Prompts", systemImage: "textformat")) {
                    PromptTextFields(prompt: $vm.prompt, undesired: $vm.undesired)
                }
                
                Section(header: Label("Image Settings", systemImage: "slider.horizontal.3")) {
                    NumberOfImagesCompactSlider(numberOfImages: $vm.numberOfImages)
                    StepsCompactSlider(steps: $vm.steps)
                    GuidanceCompactSlider(guidance: $vm.guidance)
                    SeedTextField(seed: $vm.seed)
                }
            }
            
            Divider()
            Button("Generate Image") {
                Task {
                    try await vm.generateImages()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}
