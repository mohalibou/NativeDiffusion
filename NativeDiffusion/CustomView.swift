//
//  CustomView.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 5/25/23.
//

import SwiftUI
import AppKit
import CompactSlider

struct CustomView: View {
    
    @State private var prompt = ""
    
    @State private var from = 0.0
    @State private var to = 5.0
    
    var body: some View {
        List {
            TextField("Prompt", text: $prompt, axis: .vertical)
                .lineLimit(10)
                .padding(4)
                .background(Color.secondary.opacity(0.28))
                .cornerRadius(4)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    print("hello")
                }
            CompactSlider(from: $from, to: $to) {
                Text("Prompt")
            }
            TextField("Hello", text: $prompt)
                .background(Color.secondary.opacity(0.28))
            AppKitTextField(text: $prompt)
            TextField("Enter text", text: $prompt)
                .padding()
                .background(Color.white.opacity(0.5)) // Change the opacity of the background
                .cornerRadius(10)
                .opacity(0.0) // Make the text box fully transparent
                .accentColor(.clear) // Hide the cursor and selection highlight
            CustomTextField()
            
            
            TextField("Finally?", text: $prompt, axis: .vertical)
            
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.red)
                )
            
            TextField("Finally???", text: $prompt, axis: .vertical)
                .textFieldStyle(PlainTextFieldStyle())
            
            TextField("", text: $prompt)
                .textFieldStyle(CustomTextFieldStyle())
        }
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
    }
}

public struct CustomTextFieldStyle2 : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.largeTitle) // set the inner Text Field Font
            .padding(10) // Set the inner Text Field Padding
        //Give it some style
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.primary.opacity(0.5), lineWidth: 3))
    }
}

struct CustomTextField: NSViewRepresentable {
    typealias NSViewType = NSTextField
    
    func makeNSView(context: Context) -> NSViewType {
        let textField = NSTextField()
        textField.isBordered = false
        textField.isBezeled = false
        textField.drawsBackground = true
        textField.backgroundColor = NSColor.green
        textField.textColor = NSColor.black
        textField.isEditable = false
        textField.isSelectable = false
        //textField.isEditing = false
        textField.alignment = .center
        textField.layer?.cornerRadius = 8.0
        textField.layer?.masksToBounds = true
        
        return textField
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        // Update the text or other properties if needed
    }
}

struct AppKitTextField: NSViewRepresentable {
    
    @Binding var text: String
    
    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField(frame: .zero)
        textField.isBordered = false // This removes the border
        textField.focusRingType = .none // This removes the focus ring
        textField.placeholderString = "Type something..."
        textField.backgroundColor = .secondaryLabelColor
        textField.alphaValue = 0.0
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
        let desiredHeight: CGFloat = 100 // Set the desired height here
        let currentSize = nsView.frame.size
        let newSize = CGSize(width: currentSize.width, height: desiredHeight)
        nsView.setFrameSize(newSize)
    }
    
    // Adding Coordinator to get the updated text
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextFieldDelegate {
        var parent: AppKitTextField
        
        init(_ parent: AppKitTextField) {
            self.parent = parent
        }
        
        func controlTextDidChange(_ obj: Notification) {
            if let textField = obj.object as? NSTextField {
                self.parent.text = textField.stringValue
            }
        }
    }
}

struct NoBorderTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .background(Color.gray)
            )
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        //.font(Font.system(size: 20, design: .default))
            .padding(4)
            .background(Color.secondary.opacity(0.28))
        //.frame(height: 50)
            .cornerRadius(4)
    }
}

