//
//  GeneratedImage.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/20/23.
//

import SwiftData
import SwiftUI

@Model
class GeneratedImage {
    var image: Data
    var prompt: String
    var undesired: String
    var guidance: Float
    var steps: Int
    var seed: UInt32
    var dateGenerated: Date
    
    init(image: Data, prompt: String, undesired: String, guidance: Float, steps: Int, seed: UInt32, dateGenerated: Date) {
        self.image = image
        self.prompt = prompt
        self.undesired = undesired
        self.guidance = guidance
        self.steps = steps
        self.seed = seed
        self.dateGenerated = dateGenerated
    }
}


