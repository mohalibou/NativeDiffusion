//
//  ModelPicker.swift
//  NativeDiffusion
//
//  Created by Mohamed Ali Boutaleb on 6/18/23.
//

import SwiftUI

struct ModelPicker: View {
    @State private var isFilePickerPresented = false
    @State private var model: String = "my"
    let modelsDirectory: URL? = {
        do {
            // Get the Application Support directory
            let appSupportURL = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            // Get a directory specific to your app
            let appDirectory = appSupportURL.appendingPathComponent(Bundle.main.bundleIdentifier!, isDirectory: true)
            
            // Get the Models directory inside your app's directory
            let modelsDirectory = appDirectory.appendingPathComponent("Models", isDirectory: true)
            
            return modelsDirectory
        } catch {
            // Handle failures here
            print("Failed to get Models directory URL: \(error)")
            return nil
        }
    }()
    
    var models: [URL] { loadModelFolders() }
    
    var someStrings = ["Hello", "my", "friend"]
    
    var body: some View {
        HStack {
            Picker("Model", selection: $model) {
                
                ForEach(someStrings, id: \.self) { stringe in
                    Text(stringe)
                }
                
                /*
                ForEach(models, id: \.self) { model in
                    Text(model.lastPathComponent)
                }*/
            }
            .foregroundColor(.secondary)
            .padding(.leading, 6)
            
            Button {
                isFilePickerPresented.toggle()
            } label: {
                if modelsDirectory != nil {
                    Image(systemName: "folder")
                } else {
                    Image(systemName: "folder.badge.questionmark")
                        .foregroundStyle(.red, .primary)
                }
            }
        }
        .fileImporter(isPresented: $isFilePickerPresented, allowedContentTypes: [.folder], allowsMultipleSelection: false) { result in
            importModelFolder(result: result)
        }
    }
    
    func loadModelFolders() -> [URL] {
        guard let modelsDirectory = modelsDirectory else {
            return []
        }
        
        do {
            let resourceKeys: [URLResourceKey] = [.isDirectoryKey]
            let directoryContents = try FileManager.default.contentsOfDirectory(at: modelsDirectory, includingPropertiesForKeys: resourceKeys, options: [.skipsHiddenFiles])
            
            return directoryContents.filter { url in
                do {
                    let resourceValues = try url.resourceValues(forKeys: Set(resourceKeys))
                    return resourceValues.isDirectory == true
                } catch {
                    print("Failed to get resource values for URL \(url): \(error)")
                    return false
                }
            }
        } catch {
            print("Failed to load model folders: \(error)")
            return []
        }
    }

    
    func importModelFolder(result: Result<[URL], Error>) {
        do {
            let folderURL = try result.get().first! // get the first selected URL
            
            guard let modelsDirectory = modelsDirectory else { return }
            
            // Move the selected folder to the Models directory
            let destinationURL = modelsDirectory.appendingPathComponent(folderURL.lastPathComponent)
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            try FileManager.default.copyItem(at: folderURL, to: destinationURL)
        } catch {
            // Handle failures here
            print("Failed to process folder: \(error)")
        }
    }
}






/*
 private func listDirectories(in directory: URL) -> [URL] {
 let fileManager = FileManager.default
 let keys: [URLResourceKey] = [.isDirectoryKey]
 
 let filenamesToCheck = ["TextEncoder.mlmodelc", "Unet.mlmodelc", "VAEDecoder.mlmodelc", "VAEEncoder.mlmodelc"] // Update this array with the filenames you want to check for
 
 guard let directoryEnumerator = fileManager.enumerator(at: directory,
 includingPropertiesForKeys: keys,
 options: [.skipsHiddenFiles, .skipsPackageDescendants]) else { return [] }
 
 var directories: [URL] = []
 for case let url as URL in directoryEnumerator {
 do {
 let resourceValues = try url.resourceValues(forKeys: Set(keys))
 if resourceValues.isDirectory == true {
 let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: []).map { $0.lastPathComponent }
 if filenamesToCheck.allSatisfy({ contents.contains($0) }) {
 directories.append(url)
 }
 }
 } catch {
 print("Error: ", error)
 }
 }
 return directories
 }
 */
