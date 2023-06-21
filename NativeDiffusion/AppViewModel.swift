//
//  AppViewModel.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 5/30/23.
//

import CoreML
import SwiftUI
import SwiftData
import Combine
import StableDiffusion

final class AppViewModel: ObservableObject {
    
    @Environment(\.modelContext) private var context
    
    @Published var model: String = "/Users/mohalibou/Library/Containers/mohalibou.NativeDiffusion/Data/Library/Application Support/mohalibou.NativeDiffusion/Models/AnythingV3"
    @Published var scheduler: StableDiffusionScheduler = .dpmSolverMultistepScheduler
    @Published var configuration: MLComputeUnits = .cpuAndGPU
    
    @Published var prompt: String = ""
    @Published var undesired: String = ""
    
    @Published var numberOfImages: Double = 1
    @Published var steps: Double = 50
    @Published var guidance: Double = 7.5
    @Published var seed: String = ""
    
    @Published var generatedImages: [GeneratedImage] = []
    
    // The pipeline instance should be stored as a property in the view model
    var pipeline: StableDiffusionPipeline?
    
    func generateImages() async throws {
        print("Starting...")
        let configuration = MLModelConfiguration()
        configuration.computeUnits = self.configuration
        
        print("Configuration complete. Creating pipeline...")
        do {
            let modelURL = URL(fileURLWithPath: model)
            
            pipeline = try StableDiffusionPipeline(
                resourcesAt: modelURL,
                controlNet: [],
                configuration: configuration,
                disableSafety: true,
                reduceMemory: false
            )

        } catch {
            print("Error initializing pipeline: \(error)")
            return
        }
        
        print("Pipeline created. Setting image parameters...")
        var imageSettings = StableDiffusionPipeline.Configuration(prompt: prompt)
        imageSettings.negativePrompt = undesired
        imageSettings.schedulerType = scheduler
        imageSettings.imageCount = Int(numberOfImages)
        imageSettings.stepCount = Int(steps)
        imageSettings.guidanceScale = Float(guidance)
        imageSettings.seed = UInt32(seed) ?? UInt32.random(in: 0...UInt32.max)
        
        print("Image parameters set. Generating images.")
        do {
            let image = try pipeline?.generateImages(configuration: imageSettings)[0]
            
            print("Images have been generated.")
            
            let convertingImage = NSImage(cgImage: image!, size: .zero)
            
            if let tiffData = convertingImage.tiffRepresentation {
                let imagesGenerated = GeneratedImage(image: tiffData,
                                                     prompt: imageSettings.prompt,
                                                     undesired: imageSettings.negativePrompt,
                                                     guidance: imageSettings.guidanceScale,
                                                     steps: imageSettings.stepCount,
                                                     seed: imageSettings.seed,
                                                     dateGenerated: Date())
                
                
                generatedImages = []
                generatedImages = [imagesGenerated]
                //context.insert(imagesGenerated)
            } else {
                print("Could not convert image to Data")
            }
            
           
        } catch {
            print("Error generating images: \(error)")
        }
        
        print("Done.")
    }
    
}
