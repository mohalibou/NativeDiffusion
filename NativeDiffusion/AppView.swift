//
//  ContentView.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 5/23/23.
//

import SwiftUI

struct AppView: View {
    
    @StateObject var vm = AppViewModel()
    
    var body: some View {
        NavigationSplitView {
            OptionsView(vm: vm)
                .navigationSplitViewColumnWidth(270)
        } content: {
            DetailView(vm: vm)
        } detail: {
            HistoryView()
                .navigationSplitViewColumnWidth(80)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    print("pressed")
                } label: {
                    Image(systemName: "paintpalette.fill")
                }
            }
        }
        .frame(minWidth: 800, minHeight: 400)
        .onAppear(perform: setupModelsDirectory)
    }
    
    func setupModelsDirectory() {
        do {
            // Get the Application Support directory
            let appSupportURL = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            // Create a new directory specific to your app
            let appDirectory = appSupportURL.appendingPathComponent(Bundle.main.bundleIdentifier!, isDirectory: true)
            if !FileManager.default.fileExists(atPath: appDirectory.path) {
                try FileManager.default.createDirectory(at: appDirectory, withIntermediateDirectories: true, attributes: nil)
            }
            
            // Create the Models directory inside your app's directory
            let modelsDirectory = appDirectory.appendingPathComponent("Models", isDirectory: true)
            if !FileManager.default.fileExists(atPath: modelsDirectory.path) {
                try FileManager.default.createDirectory(at: modelsDirectory, withIntermediateDirectories: true, attributes: nil)
            }
        } catch {
            // Handle failures here
            print("Failed to set up Models directory: \(error)")
        }
    }
}

#Preview {
    AppView()
}
