//
//  DetailView.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 5/27/23.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var vm: AppViewModel
    
    var body: some View {
        HStack {
            Spacer()
            if !vm.generatedImages.isEmpty {
                if let nsImage = NSImage(data: vm.generatedImages[0].image) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
            }
            Spacer()
        }
    }
}
