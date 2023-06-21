//
//  PromptTextFields.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import SwiftUI

struct PromptTextFields: View {
    @Binding var prompt: String
    @Binding var undesired: String
    @State private var showUndesired = false
    var body: some View {
        HStack(alignment: .top) {
            TextField("Prompt", text: $prompt, axis: .vertical)
                .lineLimit(10)
                .padding(4)
                .background(Color.secondary.opacity(0.28))
                .cornerRadius(4)
                .frame(maxWidth: .infinity)
            Button {
                showUndesired.toggle()
            } label: {
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(undesired.isEmpty ? .white : .red)
            }
            .popover(isPresented: $showUndesired, arrowEdge: .trailing) {
                VStack {
                    Text("Undesired Content").bold()
                    Text("Add content you don't want to see here.")
                        .font(.subheadline)
                    TextField("Undesired Content", text: $undesired, axis: .vertical)
                        .foregroundColor(.red)
                        .lineLimit(10)
                        .padding(4)
                        .background(Color.secondary.opacity(0.28))
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity)
                }
                .frame(width: 240, height: 250)
                .padding()
            }
            
        }
    }
}
