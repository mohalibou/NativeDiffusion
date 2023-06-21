//
//  HistoryView.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 5/24/23.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    
    @Query(sort: \.dateGenerated, order: .reverse) var generatedImages: [GeneratedImage]
    
    var body: some View {
        ScrollView {
            ForEach(generatedImages) { image in 
                if let nsImage = NSImage(data: image.image) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
