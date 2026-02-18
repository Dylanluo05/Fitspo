//
//  CreatePostView.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/16/26.
//

import SwiftUI

struct CreatePostView: View {
    
    @StateObject private var viewModel = CreatePostViewModel()
    
    @State private var selectedImage: UIImage?
    @State private var title = ""
    @State private var caption = ""
    @State private var hashtagText = ""
    @State private var showImagePicker = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .cornerRadius(12)
                } else {
                    Button("Select Image") {
                        showImagePicker = true
                    }
                }
                
                TextField("Write a caption...", text: $caption, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)
                
                TextField("#hashtags separated by spaces", text: $hashtagText)
                    .textFieldStyle(.roundedBorder)
                
                if viewModel.isUploading {
                    ProgressView("Uploading...")
                } else {
                    Button("Post") {
                        if let image = selectedImage {
                            viewModel.createPost(image: image, title: title, caption: caption, hashtagText: hashtagText) { success in
                                if success {
                                    dismiss()
                                }
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("Create Post")
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
    
}
