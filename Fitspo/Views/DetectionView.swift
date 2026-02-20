//
//  DetectionView.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/19/26.
//

import SwiftUI
import PhotosUI

struct DetectionView: View {

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @StateObject private var viewModel = DetectionViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Select Image")
                        .font(.headline)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedImage = uiImage
                            viewModel.uploadImage(data)
                        }
                    }
                }
                
                if let image = selectedImage {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                        
                        ForEach(viewModel.detections) { detection in
                            BoundingBoxView(
                                box: detection.box,
                                imageSize: image.size
                            )
                        }
                    }
                    .padding()
                }
                
                if viewModel.isLoading {
                    ProgressView("Analyzing...")
                        .padding()
                }
                
                if !viewModel.detections.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.detections) { detection in
                            VStack(alignment: .leading) {
                                Text(detection.label.capitalized)
                                    .font(.headline)
                                
                                Text("Confidence: \(Int(detection.confidence * 100))%")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
